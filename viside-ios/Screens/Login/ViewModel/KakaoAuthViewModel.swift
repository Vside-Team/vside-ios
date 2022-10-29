//
//  KakaoAuthViewModel.swift
//  viside-ios
//
//  Created by 김정은 on 2022/08/13.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase
import Alamofire

class KakaoAuthVM : ObservableObject {
    var firebaseDB : DatabaseReference!
    var subscriptions = Set<AnyCancellable>()
    @Published var isLoggedIn : Bool = false
    
    //카카오 앱으로 로그인 인증
    func kakaoLoginWithApp() async -> Bool {
        await withCheckedContinuation{ continuation in
            //카카오 설치 되어 있으면, 앱으로 카카오 로그인 실행
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                //error 로그인 실패
                if let error = error {
                    print("---------loginWithKakaoTalk() error : \(error)")
                    continuation.resume(returning : false)
                } else {
                    //로그인 성공
                    print("loginWithKakaoTalk() success")
                    //token값이 들어와면 성공
                    if let kakaoData = oauthToken {
                        print("DEBUG: 카카오톡 토큰 \(kakaoData)")
                        self.getUserInfo()
                        UserDefaults.standard.set(false, forKey: Const.DefaultKeys.isAppleLogin)
                        UserDefaults.standard.set(true, forKey: Const.DefaultKeys.isKakaoLogin)
                    }
                    continuation.resume(returning : true)
                    
                }
            }
        }
    }
    //카카오 웹으로 로그인 인증
    func kakaoLoginWithWeb() async -> Bool{
        await withCheckedContinuation{ continuation in
            //카카오 설치 되어 있으면, 웹에서 카카오 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount  { oauthToken, error in
                //error 로그인 실패
                if let error = error {
                    print("---------loginWithKakaoAccount () error : \(error)")
                    continuation.resume(returning: false)
                } else {
                    //로그인 성공
                    print("loginWithKakaoAccount () success")
                    //token값이 들어와면 성공
                    if let token = oauthToken {
                        print("DEBUG: 카카오톡 토큰 \(token)")
                        self.getUserInfo()
                        UserDefaults.standard.set(false, forKey: Const.DefaultKeys.isAppleLogin)
                        UserDefaults.standard.set(true, forKey: Const.DefaultKeys.isKakaoLogin)
                    }
                    continuation.resume(returning: true)
                }
            }
        }
    }
    //user info
    private func getUserInfo() {
        UserApi.shared.me {(user, error) in
            if let error = error {
                print("----------Error :\(error)----------")
            } else {
                print("-------getUserInfo() success-------")
                let name = user?.kakaoAccount?.profile?.nickname ?? ""
                let email = user?.kakaoAccount?.email
                let userID = String((user?.id)!)
                let gender = user?.kakaoAccount?.gender == .Female ? "FEMALE" : "MALE"
                var  ageRange : String = ""
                switch user?.kakaoAccount?.ageRange {
                case .Age0_9 : ageRange = "0~9"
                case .Age10_14 : ageRange = "10~14"
                case .Age15_19 :ageRange = "15~19"
                case .Age20_29 :ageRange = "20~29"
                case .Age30_39 :ageRange = "30~39"
                case .Age40_49 :ageRange = "40~49"
                case .Age50_59 :ageRange = "50~59"
                case .Age60_69 :ageRange = "60~69"
                case .Age70_79 :ageRange = "70~79"
                case .Age80_89 :ageRange = "80~89"
                case .Age90_Above :ageRange = "90~"
                case .none:
                    break
                }
                UserDefaults.standard.setValue(name, forKey: Const.DefaultKeys.name)
                UserDefaults.standard.setValue(email, forKey: Const.DefaultKeys.email)
                UserDefaults.standard.setValue(userID, forKey: Const.DefaultKeys.userId)
                UserDefaults.standard.setValue(gender, forKey: Const.DefaultKeys.gender)
                UserDefaults.standard.setValue(ageRange, forKey: Const.DefaultKeys.ageRange)
                // kakao login server 연결
                if NetworkState.isConnected() {
                    print("---------------network connected---------------")
                    //kakao login
                    UserAPI.shared.logIn( provider: "kakao",snsId: userID) { (response) in
                        switch response {
                        case .success(let loginData):
                            if let data = loginData as? LogInResponse {
                                if data.memberStatus == true {
                                    print("-------------------Kakao Login Success------------------- : \(data)")
                                    UserDefaults.standard.setValue(data.jwt, forKey: Const.DefaultKeys.jwtToken)
                                } else {
                                    //memberStatus = false -> kakao signIn
                                    UserAPI.shared.kakaoSignIn(ageRange: ageRange, email: email!, gender: gender, loginType: "kakao", name: name, snsId: userID){ (response) in
                                        switch response {
                                        case .success(let joinData):
                                            print("-------------------Kakao Join Success------------------- : \(joinData)")
                                        case .requestErr(let message):
                                            print("-------------------requestErr:\(message)------------------- ")
                                        case .pathErr:
                                            print("-------------------pathErr-------------------")
                                        case .serverErr:
                                            print("-------------------serverErr-------------------")
                                        case .networkFail:
                                            print("-------------------networkFail-------------------")
                                        }
                                    }
                                }
                            }
                        case .requestErr(let message):
                            print("-------------------requestErr:\(message)------------------- ")
                        case .pathErr:
                            print("-------------------pathErr-------------------")
                        case .serverErr:
                            print("-------------------serverErr-------------------")
                        case .networkFail:
                            print("-------------------networkFail-------------------")
                        }
                    }
                } else {
                    print("----------------network connected error-------------")
                }
             //    Create Firebase User (이메일로 회원가입)
                Auth.auth().createUser(withEmail: (email)!,
                                       password: "\(userID)") { result, error in
                    if let error = error {
                        let code = (error as NSError).code
                        switch code {
                        case 17007: //이미 가입한 메일 계정이 있는 경우 로그인
                            print(" Error :\(error.localizedDescription) ")
                            //firebase - realtime
                            Auth.auth().signIn(withEmail: (email)!,password: "\(userID)")
                            self.firebaseDB = Database.database().reference()
                            self.firebaseDB.child("userInfo").setValue(["emial":(email)!,"gender":(gender),"age_range": (ageRange) ])
                            //firebase - firestore
                            let fireStore = Firestore.firestore()
                            fireStore.collection("userInfo").document((email)!)
                                .setData(["emial":(email)!,"gender":(gender),"age_range": (ageRange) ])
                            print("-------- : User firebase database creation. --------")// 창닫기

                        default:// 그 외 에러
                            print("\(error.localizedDescription)")
                        }

                    } else {
                        print("-------- Debug: User firebase creation successful. --------")
                        print("-------- Debug: User firebase database creation. --------")
                        //firebase - realtime
                        self.firebaseDB = Database.database().reference()
                        self.firebaseDB.child("userInfo").setValue(["emial":(email)!,"gender":(gender),"age_range": (ageRange) ])
                        //firebase - firestore
                        let fireStore = Firestore.firestore()
                        fireStore.collection("userInfo").document((email)!)
                            .setData(["emial":(email)!,"gender":(gender),"age_range": (ageRange) ])
                    }
                }

            }
        }
    }
    
    @MainActor
    func KaKaoLogin(){
        print("KakaoAuthVM - KaKaoLogin() called")
        Task{
            //카카오톡 설치 여부 확인
            if (UserApi.isKakaoTalkLoginAvailable()){
                //카카오톡 앱으로 로그인 인증
                isLoggedIn = await kakaoLoginWithApp()
                
            }else{// 카카오톡 설치가 안되어 있으면
                //웹에서 카카오 계정으로 로그인
                isLoggedIn = await kakaoLoginWithWeb()
            }
        }
    }// login
    //------------------------------------------------------
    func handleKaKaoLogout() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.logout { (error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                    
                }
                else {
                    print("logout() success.")
                    //firebase user logout
                    let firebaseAuth = Auth.auth()
                    do{
                        try firebaseAuth.signOut()
                        print("signout success...")
                    }catch let signOutError as NSError{
                        print("Error : signout \(signOutError.localizedDescription)")
                    }
                    continuation.resume(returning: true)
                }
            }
        }
    }
    @MainActor
    func kakaoLogout(){
        Task{
            if await handleKaKaoLogout() {
                self.isLoggedIn = false
            }
        }
    }//logout
    //------------------------------------------------------
    
    func handleKaKaoOut() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.unlink {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    let user = Auth.auth().currentUser
                    user?.delete { error in
                        if let error = error {
                            // An error happened.
                            print("Error :  \(error.localizedDescription)")
                        } else {
                            print("Accout deleted...")
                        }
                    }
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    @MainActor
    func kakaoLinkOut(){
        Task{
            if await handleKaKaoOut() {
                self.isLoggedIn = false
            }
        }
    }//LinkOut
}

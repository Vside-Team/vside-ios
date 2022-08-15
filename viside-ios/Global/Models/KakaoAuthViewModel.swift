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
                    // _ = oauthToken
                    if let token = oauthToken {
                        print("DEBUG: 카카오톡 토큰 \(token)")
                        self.getUserInfo()
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
                    }
                    continuation.resume(returning: true)
                }
            }
        }
    }
    private func getUserInfo() {
        UserApi.shared.me {(user, error) in
            if let error = error {
                print("----------Error :\(error)----------")
            } else {
                print("-------getUserInfo() success-------")
                let kakaoUserNickName = user?.kakaoAccount?.profile?.nickname ?? ""
                let email = user?.kakaoAccount?.email
                let userID = String(describing: user?.id)
                let gender = String(describing: user?.kakaoAccount?.gender)
                let age_range = String(describing: user?.kakaoAccount?.ageRange)
                print("username:\(kakaoUserNickName),email : \(email!),gender : \(gender),age_range: \(age_range)")
                
                UserDefaults.standard.set(String(userID), forKey: DefaultKeys.userID)
                UserDefaults.standard.set(false, forKey: DefaultKeys.isAppleLogin)
               
                // Create Firebase User (이메일로 회원가입)
                Auth.auth().createUser(withEmail: (email)!,
                                       password: "\(userID)") { result, error in
                    if let error = error {
                        let code = (error as NSError).code
                        switch code {
                        case 17007: //이미 가입한 메일 계정이 있는 경우 로그인
                            //The email address is already in use by another account 출력
                            print(" Error :\(error.localizedDescription) ")
                            //firebase - realtime
                            Auth.auth().signIn(withEmail: (email)!,password: "\(userID)")
                            self.firebaseDB = Database.database().reference()
                            self.firebaseDB.child("userInfo").setValue(["emial":(email)!,"gender":(gender),"age_range": (age_range) ])
                            //firebase - firestore
                            let fireStore = Firestore.firestore()
                            fireStore.collection("userInfo").document((email)!)
                                .setData(["emial":(email)!,"gender":(gender),"age_range": (age_range) ])
                            print("-------- : User firebase database creation. --------")// 창닫기
                            
                        default:// 그 외 에러
                            print("\(error.localizedDescription)")
                        }
                        
                    } else {
                        print("-------- Debug: User firebase creation successful. --------")
                        print("-------- Debug: User firebase database creation. --------")
                        //firebase - realtime
                        self.firebaseDB = Database.database().reference()
                        self.firebaseDB.child("userInfo").setValue(["emial":(email)!,"gender":(gender),"age_range": (age_range) ])
                        //firebase - firestore
                        let fireStore = Firestore.firestore()
                        fireStore.collection("userInfo").document((email)!)
                            .setData(["emial":(email)!,"gender":(gender),"age_range": (age_range) ])
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

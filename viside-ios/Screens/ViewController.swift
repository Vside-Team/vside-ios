//
//  ViewController.swift
//  viside-ios
//
//  Created by 김정은 on 2022/08/12.
//

import UIKit
import Then
import SnapKit
import FirebaseAuth
import AuthenticationServices

class ViewController: UIViewController {
    private lazy var button = UIButton().then {
        $0.setTitle("Move to LoginViewController", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }
    private lazy var KakaoLoginBtn = UIButton().then {
        $0.layer.backgroundColor = UIColor(red: 0.957, green: 0.886, blue: 0.31, alpha: 1).cgColor
        $0.layer.cornerRadius = 4
        $0.addTarget(self, action: #selector(kakaoLoginBtnTapped), for: .touchUpInside)
    }
    private lazy var KaKaoLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = R.font.spoqaHanSansNeoBold(size: 16)
        $0.attributedText = NSMutableAttributedString(string: "카카오로 3초 만에 시작하기", attributes: [NSAttributedString.Key.kern: -0.64])
    }
    private lazy var KakaoImage = UIImageView().then {
        $0.image = UIImage(named: "kakao")
        $0.contentMode = .scaleAspectFit
    }
    
    private   lazy var AppleLoginBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 1).cgColor
        
        $0.addTarget(self, action: #selector(appleLoginBtnTappled), for: .touchUpInside)
    }
    
    private lazy var appleImage = UIImageView().then {
        $0.image = UIImage(named: "apple")
        $0.contentMode = .scaleAspectFit
    }
    private lazy var appleLabel = UILabel().then {
        $0.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        $0.font = R.font.spoqaHanSansNeoMedium(size: 18)
        $0.attributedText = NSMutableAttributedString(string: "Apple로  계속하기", attributes: [NSAttributedString.Key.kern: -0.72])
    }
    private lazy var btnStackView = UIStackView(arrangedSubviews: [KakaoLoginBtn,AppleLoginBtn]).then {
        $0.axis = .vertical
        $0.spacing = 24
        $0.distribution = .fillEqually
    }
    lazy var kakaoStackView = UIStackView(arrangedSubviews: [KakaoImage,KaKaoLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    lazy var appleStackView = UIStackView(arrangedSubviews: [appleImage,appleLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    private lazy var kakaoAuthVM : KakaoAuthVM = { KakaoAuthVM()}()
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.setConstraints()
    }//viewDidLoad
    
    private func setView(){
        view.addSubview(button)
        view.addSubview(btnStackView)
        view.addSubview(kakaoStackView)
        view.addSubview(appleStackView)
    }
    private func setConstraints(){
        button.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(100)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 250, height: 50))
        }
        KakaoLoginBtn.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(272)
        }
        btnStackView.snp.makeConstraints{
            $0.bottom.equalTo(safeArea).inset(76)
            $0.centerX.equalTo(safeArea)
        }
        kakaoStackView.snp.makeConstraints{
            $0.leading.equalTo(KakaoLoginBtn).inset(37)
            $0.centerY.equalTo(KakaoLoginBtn)
        }
        appleStackView.snp.makeConstraints{
            $0.leading.equalTo(AppleLoginBtn).inset(59)
            $0.centerY.equalTo(AppleLoginBtn)
        }
    }
    //MARK: -버튼액션
    @objc
    private func buttonDidTap() {
        Utils.setRootViewController(LoginViewController())
    }
    @objc func kakaoLoginBtnTapped(){
        print("kakaoLoginBtnTapped() called")
         kakaoAuthVM.KaKaoLogin()
    }
    @objc func appleLoginBtnTappled(){
        print("appleLoginBtnTappled() called")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        let autorizationController = ASAuthorizationController(authorizationRequests: [request])
        autorizationController.delegate = self
        autorizationController.presentationContextProvider = self
        autorizationController.performRequests()
    }
}
extension ViewController  : ASAuthorizationControllerDelegate{
    //apple id 연동 실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    //apple id 연동 성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential{
        case let credentials as ASAuthorizationAppleIDCredential :
            
            let userID = credentials.user
            let appleUserFirstName = credentials.fullName?.givenName ?? ""
            let appleUserLastName = credentials.fullName?.familyName ?? ""
            let appleUserEmail = credentials.email ?? ""
            
            if  let authorizationCode = credentials.authorizationCode,
                let identityToken = credentials.identityToken,
                let authString = String(data: authorizationCode, encoding: .utf8),
                let tokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
            }
            print("userID : \(userID)")
            print("userFullName : \(appleUserFirstName) \(appleUserLastName)")
            print("userEmail : \(appleUserEmail)")
            
            let defaults = UserDefaults.standard
            defaults.set(userID, forKey: DefaultKeys.userID)
            defaults.set(appleUserFirstName, forKey: DefaultKeys.firstName)
            defaults.set(appleUserLastName, forKey: DefaultKeys.lastName)
            defaults.set(appleUserEmail, forKey: DefaultKeys.email)
            defaults.set(true, forKey: DefaultKeys.isAppleLogin)
            
        case let credentials as ASPasswordCredential :
            let username = credentials.user
            let password = credentials.password
            print(" 이미 존재함")
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            let alert = UIAlertController(title: "Apple SignIn", message: "Something went wrong with yout Apple SignIn", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
//로그인 진행 화면
extension ViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}





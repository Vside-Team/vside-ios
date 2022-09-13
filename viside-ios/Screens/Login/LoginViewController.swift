//
//  LoginViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/08/14.
//

import UIKit
import Then
import SnapKit
import AuthenticationServices

final class LoginViewController: UIViewController, Layout {
    
    private lazy var kakaoButton = LoginButton(type: .kakao).then {
        $0.addTarget(self,
                     action: #selector(kakaoButtonDidTap),
                     for: .touchUpInside)
    }
    private lazy var appleButton = LoginButton(type: .apple).then {
        $0.addTarget(self,
                     action: #selector(appleButtonDidTap),
                     for: .touchUpInside)
    }
    private let viewModel = LoginViewModel()
    private lazy var kakaoAuth = KakaoAuthVM()
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.setConstraints()
        self.configure()
    }
    func setViews() {
        self.view.addSubview(kakaoButton)
        self.view.addSubview(appleButton)
    }
    func setConstraints() {
        kakaoButton.snp.makeConstraints {
            $0.centerX.equalTo(safeArea)
            $0.size.equalTo(CGSize(width: 272, height: 60))
            $0.bottom.equalTo(appleButton.snp.top).offset(-24)
        }
        appleButton.snp.makeConstraints {
            $0.centerX.equalTo(safeArea)
            $0.size.equalTo(CGSize(width: 272, height: 60))
            $0.bottom.equalTo(safeArea).inset(76)
        }
    }
    private func configure() {
        self.view.backgroundColor = Color.g950
    }
    @objc
    private func kakaoButtonDidTap() {
        self.viewModel.setLoginType(.kakao)
        self.kakaoAuth.KaKaoLogin()
    }
    @objc
    private func appleButtonDidTap() {
        self.viewModel.setLoginType(.apple)
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
              
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}
// MARK: - Apple
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: "다시 시도해주세요 어쩌고",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: nil))
        self.present(alert, animated: true)
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        self.viewModel.appleAuth(authorization.credential)
    }
}
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

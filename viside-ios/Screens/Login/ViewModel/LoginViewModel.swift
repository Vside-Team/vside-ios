//
//  LoginViewModel.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/08/15.
//

import Foundation
import AuthenticationServices

final class LoginViewModel {
    private var loginType = LoginType.kakao
    
}
extension LoginViewModel {
    func setLoginType(_ type: LoginType) {
        self.loginType = type
    }
    func appleAuth(_ auth: ASAuthorizationCredential) {
        switch auth {
        case let credential as ASAuthorizationAppleIDCredential:
            // 데이터 추출
            credential.user
            break
        default:
            break
        }
    }
}

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
            let userIdentifier =  credential.user
            var email = credential.email ?? ""
            let name: String?
            if let nameProvided = credential.fullName {
                let firstName = nameProvided.givenName ?? ""
                let lastName = nameProvided.familyName ?? ""
                name = "\(firstName) \(lastName)"
            } else {
                name = nil
            }
            var authCode = ""
            if let data = credential.authorizationCode {
                authCode = String(data: data, encoding: .utf8) ?? ""
            }
            if email.isEmpty {
                if let tokenString = String(data: credential.identityToken ?? Data(), encoding: .utf8) {
                    email = decode(jwtToken: tokenString)["email"] as? String ?? ""
                }
            }
            if NetworkState.isConnected() {
                UserAPI.shared.logIn( provider: "apple",snsId: userIdentifier){ (response) in
                    switch response {
                    case .success(let loginData):
                        print("success : \(loginData)")
                        if let data = loginData as? LogInResponse {
                            if data.memberStatus {
                                print("-------------------Apple Login Success -------------------: \(data)")
                                UserDefaults.standard.setValue(data.jwt, forKey: Const.DefaultKeys.jwtToken)
                            } else {
                                UserAPI.shared.appleSignIn(email: email,loginType:"apple",name: name!,snsId: userIdentifier){ (response) in
                                    switch response {
                                    case .success(let joinData):
                                        print("-------------------Apple Join Success -------------------: \(joinData)")
                                    case .failure(let error):
                                        print("error:\(error)")
                                    }
                                }
                            }
                        }
                    case .failure(let error):
                        print("error:\(error)")
                    }
                }
                UserDefaults.standard.set(true, forKey: Const.DefaultKeys.isAppleLogin)
                UserDefaults.standard.set(false, forKey: Const.DefaultKeys.isKakaoLogin)
            } else {
                print("---------------network connected error---------------")
                
            }
        default:
            break
        }
    }
    
    private func decode(jwtToken jwt: String) -> [String: Any] {
        
        func base64UrlDecode(_ value: String) -> Data? {
            var base64 = value
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")
            
            let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
            let requiredLength = 4 * ceil(length / 4.0)
            let paddingLength = requiredLength - length
            if paddingLength > 0 {
                let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
                base64 = base64 + padding
            }
            return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
        }
        
        func decodeJWTPart(_ value: String) -> [String: Any]? {
            guard let bodyData = base64UrlDecode(value),
                  let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
                return nil
            }
            
            return payload
        }
        
        let segments = jwt.components(separatedBy: ".")
        return decodeJWTPart(segments[1]) ?? [:]
    }
    
    
}


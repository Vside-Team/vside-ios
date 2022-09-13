//
//  UserAPI.swift
//  viside-ios
//
//  Created by 김정은 on 2022/08/22.
//
import Foundation
import Moya
import Alamofire

public class UserAPI {
    
    
    class DefaultAlamofireSession: Alamofire.Session {
        static let shared: DefaultAlamofireSession = {
            let configuration = URLSessionConfiguration.default
            configuration.headers = .default
            configuration.timeoutIntervalForRequest = 30 // request timeout
            configuration.timeoutIntervalForResource = 30 // resource timeout
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return DefaultAlamofireSession(configuration: configuration)
        }()
    }
    static let shared = UserAPI()
    var  userProvider = MoyaProvider<UserService>(session: DefaultAlamofireSession.shared, plugins:  [MoyaLoggingPlugin()])
    private init() { }
    
    func logIn( provider: String,snsId: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.logIn(provider: provider,snsId: snsId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let data = try filteredResponse.map(LogInResponse.self)
                    print("loginResposedata : \(data)")
                    completion(.success(data))
                    print("success login : \(data)")
                } catch let error {
                    print("login error: \(error)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func kakaoSignIn(ageRange : String?, email : String ,gender : String?,  loginType : String , name : String , snsId : String , completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.kakaoSignIn(ageRange: ageRange, email: email, gender: gender, loginType: loginType, name: name, snsId: snsId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let data = try filteredResponse.map(JoinResponse.self)
                    print("joinResponse data : \(data)")
                    completion(.success(data))
                    print("success join : \(data)")
                } catch let error {
                    print("join error: \(error)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func appleSignIn( email : String , loginType : String , name : String , snsId : String , completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.appleSignIn(email: email, loginType: loginType, name: name, snsId: snsId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let data = try filteredResponse.map(JoinResponse.self)
                    print("joinResponse data : \(data)")
                    completion(.success(data))
                    print("success join : \(data)")
                } catch let error {
                    print("join error: \(error)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

class NetworkState {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

//
//  UserService.swift
//  viside-ios
//
//  Created by 김정은 on 2022/08/22.
//
import Foundation
import Moya

enum UserService {
    case kakaoSignIn(ageRange : String?, email : String ,gender : String?,  loginType : String , name : String , snsId : String )
    case appleSignIn( email : String ,  loginType : String , name : String , snsId : String )
    case logIn(provider: String,snsId: String)
}

extension UserService : TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    var path: String {
        switch self {
        case .kakaoSignIn , .appleSignIn:
            return "/signin"
        case .logIn:
            return "/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .kakaoSignIn,.appleSignIn, .logIn :
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .kakaoSignIn(let ageRange , let email , let gender , let loginType , let name , let snsId ) :
            return .requestParameters(parameters: ["ageRange" : ageRange ?? "" , "email" : email , "gender" : gender ?? "" , "loginType" : loginType , "name" : name , "snsId" : snsId], encoding: JSONEncoding.default)
        case .appleSignIn( let email ,  let loginType , let name , let snsId ) :
            return .requestParameters(parameters: [ "email" : email ,  "loginType" : loginType , "name" : name , "snsId" : snsId], encoding: JSONEncoding.default)
        case .logIn(let provider,let snsId):
                    return .requestParameters(parameters: [ "provider" : provider,"snsId" : snsId], encoding: JSONEncoding.default)
        
        }
    }
    var validationType: Moya.ValidationType {
           return .successAndRedirectCodes
        
       }
    
    var headers: [String: String]? {
        switch self {
        case .kakaoSignIn,.appleSignIn ,.logIn :
                    return Const.Header.applicationJsonHeader()
        }
    }
}

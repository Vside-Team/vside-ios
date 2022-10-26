//
//  MyAPI.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/26.
//

import Foundation
import Moya

enum MyUserService {
    case logOut
    case linkOut(snsId : String )
}

extension MyUserService : TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    var path: String {
        switch self {
        case .logOut :
           return "/logout1"
        case .linkOut :
            return "/withdrawal"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .logOut :
            return .post
        case .linkOut :
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .logOut :
            return .requestPlain
        case .linkOut(let snsId) :
            return .requestParameters(parameters: ["snsId" : snsId], encoding: JSONEncoding.default)
        }
    }
    var validationType: Moya.ValidationType {
           return .successAndRedirectCodes
       }
    
    var headers: [String: String]? {
        return Const.Header.bearerHeader()
      }
    }


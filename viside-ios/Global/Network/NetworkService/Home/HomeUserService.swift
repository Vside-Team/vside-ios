//
//  HomeUserService.swift
//  viside-ios
//
//  Created by 김정은 on 2022/09/28.
//

import Foundation
import Moya

enum HomeUserService {
    case homeuserName
}

extension HomeUserService : TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    
    }
    var path: String {
        switch self {
        case .homeuserName :
            return "/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .homeuserName :
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .homeuserName :
            return .requestPlain
        }
    }
    var validationType: Moya.ValidationType {
           return .successAndRedirectCodes
        
       }
    
    var headers: [String: String]? {
        return Const.Header.bearerHeader()
      }
    }



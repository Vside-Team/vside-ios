//
//  SearchService.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/11/01.
//

import Foundation
import Moya

enum SearchService {
    case search(keywords: [String])
}

extension SearchService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .search: return "search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .search(keywords: let keywords):
            return .requestJSONEncodable(["keywords": keywords])
        }
    }
    var validationType: Moya.ValidationType {
           return .successAndRedirectCodes
        
       }
    
    var headers: [String: String]? {
        return Const.Header.header
      }
}

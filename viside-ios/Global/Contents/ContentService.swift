//
//  ContentService.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/07.
//

import Foundation
import Moya

enum ContentService {
    case scrap(contentId : Int)
}

extension ContentService : TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    var path: String {
        switch self {
        case .scrap(contentId :let contentId ) :
            return "/scrap/\(contentId)"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .scrap(contentId: _):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .scrap(let contentId ) :
            return .requestParameters(parameters: ["contentId": contentId], encoding: JSONEncoding.default)
        }
    }
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
        
    }
    
    var headers: [String: String]? {
        switch self {
        case .scrap(contentId: _) :
            return Const.Header.bearerHeader()
        }
    }
}

//
//  LoginType.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/08/14.
//

import Foundation

enum LoginType {
    case kakao, apple
    
    var title: String {
        switch self {
        case .kakao:
            return "카카오로 3초 만에 시작하기"
        case .apple:
            return "Apple로 계속하기"
        }
    }
}

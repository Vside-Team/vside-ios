//
//  alertType.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/25.
//

import Foundation

enum AlertType {
    case logOut, linkOut , confirm
    
    var title: String {
        switch self {
        case .logOut:
            return "로그아웃을 하셔도 언제든지 \n다시 돌아올 수 있어요!"
        case .linkOut:
            return "계정을 삭제하면 이은지님의\n기록이 모두 사라져요."
        case .confirm :
            return "탈퇴가 완료되었어요.\n언제든지 다시 돌아오실 수 있어요!"
        }
    }
    var subTitle : String {
        switch self {
        case .logOut :
            return "로그아웃을 진행하시겠어요?"
        case .linkOut :
            return "삭제를 진행하시겠어요?"
        case .confirm :
            return ""
        }
    }
}

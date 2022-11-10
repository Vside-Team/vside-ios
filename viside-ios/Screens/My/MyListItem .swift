//
//  MyListItem .swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/12.
//

import Foundation
struct MyPageListItem: Hashable {
    let id = UUID()
    var listTitle: String
}
extension MyPageListItem {
    static let list : [MyPageListItem] = [MyPageListItem(listTitle: "1:1 문의"),
                                      MyPageListItem(listTitle: "서비스 이용방침"),
                                      MyPageListItem(listTitle: "개인정보 처리방안"),
                                      MyPageListItem(listTitle: "로그아웃"),
                                      MyPageListItem(listTitle: "탈퇴하기")]
}

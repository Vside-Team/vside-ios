//
//  MyListItem .swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/12.
//

import Foundation
struct MyPageListItem: Hashable {
    var listTitle: String
}
extension MyPageListItem {
    static let list : [MyPageListItem] = [MyPageListItem(listTitle: "1:1 문의"),
                                      MyPageListItem(listTitle: "서비스 이용방침"),
                                      MyPageListItem(listTitle: "개인정보 처리방안"),
                                      MyPageListItem(listTitle: "로그아웃"),
                                      MyPageListItem(listTitle: "탈퇴하기")]
}
struct MyBookListItem : Hashable {
    var  imgURl : String
}
extension MyBookListItem {
    static let list : [MyBookListItem] = [MyBookListItem(imgURl: "1"),
                                          MyBookListItem(imgURl: "2"),
                                          MyBookListItem(imgURl: "3"),
                                          MyBookListItem(imgURl: "4"),
                                          MyBookListItem(imgURl: "5"),
                                          MyBookListItem(imgURl: "6"),
                                          MyBookListItem(imgURl: "7"),
                                          MyBookListItem(imgURl: "8"),
                                          MyBookListItem(imgURl: "9"),
                                          MyBookListItem(imgURl: "10"),
                                          MyBookListItem(imgURl: "11"),
                                          MyBookListItem(imgURl: "12"),
                                          MyBookListItem(imgURl: "13"),
                                          MyBookListItem(imgURl: "14"),
                                          MyBookListItem(imgURl: "15"),
                                          MyBookListItem(imgURl: "16"),
                                          MyBookListItem(imgURl: "17"),
                                          MyBookListItem(imgURl: "18"),
                                          MyBookListItem(imgURl: "19"),
                                          MyBookListItem(imgURl: "20"),
                                          MyBookListItem(imgURl: "21"),
                                          MyBookListItem(imgURl: "22"),
                                          MyBookListItem(imgURl: "23"),
                                          MyBookListItem(imgURl: "24")

    ]
}

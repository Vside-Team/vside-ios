//
//  Header.swift
//  viside-ios
//
//  Created by 김정은 on 2022/08/22.
//
//[✅]
import Foundation
extension Const {
    struct Header {
        //request
        static func applicationJsonHeader() -> [String: String] {
            ["Content-Type": "application/json"]
        }
        static func bearerHeader() -> [String: String] {
            ["Authorization": "\(UserDefaults.standard.string(forKey:Const.DefaultKeys.jwtToken) ?? "")"]
        }
    }
}

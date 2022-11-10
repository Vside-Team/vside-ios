//
//  MyUserAPI.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/26.
//


import Foundation
import Moya

public class MyAPI {
    var myProvider = MoyaProvider<MyUserService>(plugins : [MoyaLoggingPlugin()])
}

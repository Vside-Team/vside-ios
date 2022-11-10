//
//  HomeUserNameAPI.swift
//  viside-ios
//
//  Created by 김정은 on 2022/09/28.
//

import Foundation
import Moya
import Alamofire

public class HomeAPI {
    var homeProvider = MoyaProvider<HomeUserService>(plugins : [MoyaLoggingPlugin()])
}

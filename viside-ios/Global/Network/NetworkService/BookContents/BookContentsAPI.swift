//
//  BookContentsAPI.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/11.
//

import Moya

public class ContentAPI {
    var contentProvider = MoyaProvider<ContentService>(plugins : [MoyaLoggingPlugin()])
}

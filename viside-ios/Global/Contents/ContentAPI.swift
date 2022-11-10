//
//  ContentAPI.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/07.
//

import Foundation
import Moya

public class ContentAPI {
    var contentProvider = MoyaProvider<ContentService>(plugins : [MoyaLoggingPlugin()])
}

//
//  NetworkResult.swift
//  viside-ios
//
//  Created by 김정은 on 2022/08/22.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failure(T)
}

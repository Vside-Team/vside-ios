//
//  ViewModelType.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/03.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}

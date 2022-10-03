//
//  ReusableView.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/27.
//

import UIKit

/// 재사용 뷰 프로토콜
/// - identifier 지정
protocol ReusableView: AnyObject {}


extension ReusableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

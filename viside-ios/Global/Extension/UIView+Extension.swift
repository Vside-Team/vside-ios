//
//  UIView+Extension.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/27.
//

import UIKit

extension UIView {
    func addShadow(color: UIColor? = Color.g400,
                   opacity: Float = 0.4,
                   offset: CGSize = CGSize(width: 0, height: 0),
                   radius: CGFloat = 12) {
        self.layer.shadowColor = color?.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius / 2
        self.layer.masksToBounds = false
    }
}

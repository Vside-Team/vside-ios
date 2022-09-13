//
//  UITabBarItem+Extension.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//

import UIKit

extension UITabBarItem {
    convenience init(image: UIImage?, selectedImage: UIImage?) {
        self.init()
        self.title = nil
        self.image = image?.withRenderingMode(.alwaysOriginal)
        self.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        self.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
    }
}

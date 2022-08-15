//
//  Utils.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/08/15.
//

import UIKit

public final class Utils {
    
    
    class func setRootViewController(_ viewController: UIViewController) {
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

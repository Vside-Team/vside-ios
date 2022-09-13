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
//    class func setRootViewController(vc: UIViewController) {
//        DispatchQueue.main.async {
//            let sceneDelegate = UIApplication.shared.delegate as! SceneDelegate
//            sceneDelegate.window?.rootViewController = vc
//            sceneDelegate.window?.makeKeyAndVisible()
//        }
//    }
    // MARK: - Font
    class func setMontserratSpoqa(size: Typography.Size, weight: Typography.Weight) -> UIFont {
        switch weight {
        case .regular:
            return R.font.montserratSpoqaRegular(size: size.rawValue) ?? .systemFont(ofSize: size.rawValue, weight: .regular)
        case .medium:
            return R.font.montserratSpoqaMedium(size: size.rawValue) ?? .systemFont(ofSize: size.rawValue, weight: .medium)
        case .semiBold:
            return R.font.montserratSemiBold(size: size.rawValue) ?? .systemFont(ofSize: size.rawValue, weight: .semibold)
        case .bold:
            return R.font.montserratSpoqaBold(size: size.rawValue) ?? .systemFont(ofSize: size.rawValue, weight: .bold)
        case .extraBold:
            return R.font.montserratExtraBold(size: size.rawValue) ?? .systemFont(ofSize: size.rawValue, weight: .bold)
        }
    }
}

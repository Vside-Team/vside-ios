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
    class func push(nav: UINavigationController?, vc: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            vc.hidesBottomBarWhenPushed = true
            nav?.pushViewController(vc, animated: animated)
        }
        
    }
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
    class func layoutAnimate(_ delegate: UIViewController,
                             withDuration duration: TimeInterval = 0.3,
                             delay: TimeInterval = 0,
                             options: UIView.AnimationOptions = [.curveEaseIn]) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: options,
                       animations: ({
            delegate.view.layoutIfNeeded()
        }), completion: nil)
    }
}

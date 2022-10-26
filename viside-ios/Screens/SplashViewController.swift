//
//  SplashViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//

import UIKit

final class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemMint
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            Utils.setRootViewController(TabBarController())
          //  Utils.setRootViewController(LoginViewController())
        }
    }
}

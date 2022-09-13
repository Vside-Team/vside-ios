//
//  HomeNavigationViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//

import UIKit

final class HomeNavigationViewController: BasicNavigationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func push() {
        self.pushViewController(HomeViewController(), animated: true)
    }
}

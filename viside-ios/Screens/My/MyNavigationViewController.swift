//
//  MyNavigationViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//


import UIKit

final class MyNavigationViewController: BasicNavigationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func push() {
        self.pushViewController(MyViewController(), animated: true)
    }
}

//
//  BasicNavigationViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//

import UIKit

class BasicNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.push()
    }
    private func configure() {
        self.navigationBar.isHidden = true
    }
    
    func push() {
    }
    
}

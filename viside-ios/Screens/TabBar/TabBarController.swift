//
//  TabBarController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//

import UIKit

final class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setItem()
    }
    
    private func setItem() {
        
        self.tabBar.clipsToBounds = true
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        let firstTab = HomeNavigationViewController()
        let secondTab = SearchNavigationViewController()
        let thirdTab = MyNavigationViewController()
        
        firstTab.tabBarItem = UITabBarItem(image: R.image.tab.home.normal(),
                                           selectedImage: R.image.tab.home.selected())
        secondTab.tabBarItem = UITabBarItem(image: R.image.tab.search.normal(),
                                           selectedImage: R.image.tab.search.selected())
        thirdTab.tabBarItem = UITabBarItem(image: R.image.tab.my.normal(),
                                           selectedImage: R.image.tab.my.selected())
        
        self.setViewControllers([firstTab, secondTab, thirdTab], animated: false)
    }
}

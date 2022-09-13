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
        self.configure()
        self.setItem()
    }
    
    private func configure() {
        UITabBar.clearShadow()
        self.tabBar.layer.applyShadow(
            color: Color.g500,
            alpha: 0.1,
            x: 0, y: -3,
            blur: 10)
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
    private func setItem() {
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

//
//  ParentMainViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/27.
//

import UIKit
import Then
import SnapKit

class ParentMainViewController: UIViewController {
    
    let navigationView = NavigationView()
    
    lazy var safeArea = self.view.safeAreaLayoutGuide
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.setConstraints()
    }
    
    private func setViews() {
        self.view.addSubview(navigationView)
    }
    private func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(64)
        }
    }
    
}

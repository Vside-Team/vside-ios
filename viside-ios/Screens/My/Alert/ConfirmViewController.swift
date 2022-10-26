//
//  ConfirmViewController.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/26.
//

import UIKit
import SnapKit
import Then
class ConfirmViewController: UIViewController,AlertConfirm {
    let confirmView: ConfirmView
    init(type : AlertType , title : String ){
        self.confirmView = ConfirmView(type: type, title: title)
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .clear
        self.setView()
        self.setConstraints()
        confirmView.delegate = self
    }
    func setView(){
        self.view.addSubview(self.confirmView)
    }
    func setConstraints(){
        confirmView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    func action() {
        Utils.setRootViewController(TabBarController())
    }
    required init?(coder: NSCoder) { fatalError() }
}

//
//  LogOutViewController.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/25.
//

import UIKit
import SnapKit
import Then
import AuthenticationServices
class AlertViewController: UIViewController, AlertDelegate {
    let alertView: AlertView
    init(type : AlertType , title : String, subTitle : String ){
        self.alertView = AlertView(type: type, title: title, subTitle: subTitle)
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .clear
        self.setView()
        self.setConstraints()
        alertView.delegate = self
      }
    func setView(){
        self.view.addSubview(self.alertView)
    }
    func setConstraints(){
        alertView.snp.makeConstraints {
          $0.edges.equalToSuperview()
        }
    }
    func action() {
        if alertView.type == .logOut  {
            print("action")
            myLogout()
            UserDefaults.standard.removeObject(forKey: Const.DefaultKeys.jwtToken)
            KakaoAuthVM().kakaoLogout()
            Utils.setRootViewController(SplashViewController())
        } else {
            myLinkout()
            UserDefaults.standard.removeObject(forKey: Const.DefaultKeys.jwtToken)
            KakaoAuthVM().kakaoLinkOut()
            let confirm = ConfirmViewController(type: .confirm, title:  AlertType.confirm.title)
            confirm.modalPresentationStyle = .overFullScreen
            self.present(confirm, animated: false)
            print("tapped ")
        }
    }
    func cancel() {
        print("cancel")
        self.dismiss(animated: false, completion: nil)
    }
      required init?(coder: NSCoder) { fatalError() }
    }

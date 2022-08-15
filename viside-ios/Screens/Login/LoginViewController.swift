//
//  LoginViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/08/14.
//

import UIKit
import Then
import SnapKit

final class LoginViewController: UIViewController, Layout {
    
    private lazy var kakaoButton = LoginButton(type: .kakao).then {
        $0.addTarget(self,
                     action: #selector(kakaoButtonDidTap),
                     for: .touchUpInside)
    }
    private lazy var appleButton = LoginButton(type: .apple).then {
        $0.addTarget(self,
                     action: #selector(appleButtonDidTap),
                     for: .touchUpInside)
    }
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.setConstraints()
        self.configure()
    }
    func setViews() {
        self.view.addSubview(kakaoButton)
        self.view.addSubview(appleButton)
    }
    func setConstraints() {
        kakaoButton.snp.makeConstraints {
            $0.centerX.equalTo(safeArea)
            $0.size.equalTo(CGSize(width: 272, height: 60))
            $0.bottom.equalTo(appleButton.snp.top).offset(-24)
        }
        appleButton.snp.makeConstraints {
            $0.centerX.equalTo(safeArea)
            $0.size.equalTo(CGSize(width: 272, height: 60))
            $0.bottom.equalTo(safeArea).inset(76)
        }
    }
    private func configure() {
        self.view.backgroundColor = .black
    }
    @objc
    private func kakaoButtonDidTap() {
        
    }
    @objc
    private func appleButtonDidTap() {
        
    }
}

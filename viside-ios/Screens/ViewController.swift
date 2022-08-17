//
//  ViewController.swift
//  viside-ios
//
//  Created by 김정은 on 2022/08/12.
//

import UIKit
import Then
import SnapKit
import FirebaseAuth
import AuthenticationServices

class ViewController: UIViewController ,Layout{
    private lazy var button = UIButton().then {
        $0.setTitle("Move to LoginViewController", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
    }//viewDidLoad
    
    func setViews() {
        self.view.addSubview(button)
    }
    
    func setConstraints() {
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    //MARK: -버튼액션
    @objc
    private func buttonDidTap() {
        Utils.setRootViewController(LoginViewController())
    }
}

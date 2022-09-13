//
//  ViewController.swift
//  viside-ios
//
//  Created by 김정은 on 2022/08/12.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {

    
    private lazy var titleLabel = UILabel().then {
        $0.font = R.font.spoqaHanSansNeoBold(size: 12)
        $0.textColor = Color.main
        $0.text = Strings.Main.title
        
    }
    private let imageView = UIImageView().then {
        $0.image = R.image.kakao()
    }
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.setConstraints()
    }

    private func setView() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(imageView)
    }
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(safeArea)
            $0.top.equalTo(safeArea).inset(30)
        }
    }
}


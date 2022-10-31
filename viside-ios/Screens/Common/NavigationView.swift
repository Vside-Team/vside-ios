//
//  NavigationView.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import UIKit
import Then
import SnapKit

final class NavigationView: UIView, Layout {
    
    private let titleLabel = UILabel().then {
        $0.font = Font.xl2.bold
        $0.textColor = Color.g950
    }
    init() {
        super.init(frame: .zero)
        self.setViews()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setViews() {
        self.addSubview(titleLabel)
    }
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(22)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    func setFont(_ font: UIFont?) {
        self.titleLabel.font = font
    }
}

//
//  LoginButton.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/08/14.
//

import UIKit
import Then
import SnapKit

final class LoginButton: UIView, Layout {
    private lazy var iconImageView = UIImageView().then {
        $0.image = type == .kakao ? R.image.kakao() : R.image.apple()
        $0.contentMode = .scaleAspectFit
    }
    private lazy var titleLabel = UILabel().then {
        $0.text = type.title
        $0.textColor = type == .kakao ? .black : .white
        $0.font = type == .kakao ? Font.base.medium : Font.lg.medium
    }
    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(titleLabel)
    }
    private lazy var button = UIButton().then {
        $0.backgroundColor = .clear
    }
    private var type: LoginType
    
    init(type: LoginType) {
        self.type = type
        super.init(frame: .zero)
        self.setViews()
        self.setConstraints()
        self.configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setViews() {
        self.addSubview(stackView)
        self.addSubview(button)
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    private func configure() {
        self.layer.cornerRadius = 4
        self.backgroundColor = self.type == .kakao ? Color.kakao : .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = self.type == .kakao ? Color.kakao?.cgColor : Color.g700?.cgColor
    }
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        self.button.addTarget(target,
                              action: action,
                              for: controlEvents)
    }
    
}

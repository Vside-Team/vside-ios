//
//  refreshButton.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/11/06.
//

import UIKit
import Then
import SnapKit

final class RefreshButton: UIView, Layout {
    
    private let iconImageView = UIImageView().then {
        $0.image = R.image.icon.refresh()
        $0.contentMode = .scaleAspectFit
    }
    private let titleLabel = UILabel().then {
        $0.text = Strings.Search.Filter.refresh
        $0.font = Font.sm.regular
        $0.textColor = Color.g700
    }
    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 2
        $0.distribution = .fillProportionally
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(titleLabel)
    }
    private lazy var background = UIView().then {
        $0.layer.cornerRadius = 10
        $0.addShadow(color: Color.g200,
                     opacity: 0.7,
                     offset: CGSize(width: 0, height: 2),
                     radius: 6)
        $0.backgroundColor = .white
        $0.addSubview(stackView)
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
        self.addSubview(background)
    }
    
    func setConstraints() {
        background.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    
}

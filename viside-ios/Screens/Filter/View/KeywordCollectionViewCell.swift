//
//  KeywordCollectionViewCell.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/11/02.
//

import UIKit
import Then
import SnapKit

final class KeywordCollectionViewCell: UICollectionViewCell, Layout, ReusableView {
    
    private lazy var titleLabel = UILabel().then {
        $0.font = Font.base.regular
        $0.textColor = Color.g600
        $0.textAlignment = .center
    }
    private lazy var background = UIView().then {
        $0.backgroundColor = Color.g50
        $0.layer.cornerRadius = 18
        $0.addSubview(titleLabel)
    }
    
    override init(frame: CGRect) {
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
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind(_ title: String?) {
        self.titleLabel.text = title
    }
}

//
//  FilterTableViewCell.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import UIKit
import Then
import SnapKit

final class FilterTableViewCell: UITableViewCell, ReusableView, Layout {
    private lazy var titleLabel = UILabel().then {
        $0.font = Font.base.bold
        $0.textColor = Color.g800
        $0.text = "test"
    }
    private lazy var collectionView = FilterCollectionView()
    private lazy var background = UIView().then {
        $0.addSubview(titleLabel)
        $0.addSubview(collectionView)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setViews()
        self.setConstraints()
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setViews() {
        self.contentView.addSubview(background)
    }
    
    func setConstraints() {
        background.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 20,
                                                           left: 21,
                                                           bottom: 14,
                                                           right: 21))
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(5)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func configure() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = Color.g25
    }
    func bind(_ keyword: Keyword) {
        self.titleLabel.text = keyword.category?.first
        
    }
}

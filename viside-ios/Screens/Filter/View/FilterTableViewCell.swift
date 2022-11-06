//
//  FilterTableViewCell.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import UIKit
import Then
import SnapKit

protocol SelectFilterDelegate {
    func selectCategory(in collectionIndexPath: IndexPath, on tableIndexPath: IndexPath)
}
final class FilterTableViewCell: UITableViewCell, ReusableView, Layout {
    private lazy var titleLabel = UILabel().then {
        $0.font = Font.base.bold
        $0.textColor = Color.g800
    }
    private lazy var collectionView = CategoryCollectionView().then {
        $0.dataSource = self
        $0.delegate = self
    }
    private lazy var background = UIView().then {
        $0.addSubview(titleLabel)
        $0.addSubview(collectionView)
    }
    
    private var data: Keyword?
    private var indexPath: IndexPath?
    var delegate: SelectFilterDelegate?
    
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
            $0.height.equalTo(100)
        }
    }
    private func configure() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = Color.g25
    }
    func bind(_ keyword: Keyword, indexPath: IndexPath) {
        self.titleLabel.text = keyword.category?.first
        self.data = keyword
        self.indexPath = indexPath
        self.collectionView.reloadData()
        self.resize()
    }
    private func resize() {
        let totalWidth: CGFloat = self.data?.keywords?.map({ $0.insetSize().width }).reduce(0, +) ?? 0
        let totalXInset: CGFloat = CGFloat(12 * ((self.data?.keywords?.count ?? 0) - 1))
        let numberOfRows = (totalWidth + totalXInset) / (UIScreen.main.bounds.width - 42)
        let height: CGFloat = numberOfRows * 36 + 10 * (numberOfRows - 1)
        self.collectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
}
extension FilterTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.data?.keywords?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as KeywordCollectionViewCell
        cell.bind(self.data?.keywords?[indexPath.row])
        return cell
    }
}
extension FilterTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.data?.keywords?[indexPath.row].insetSize() ?? CGSize(width: 50, height: 36)
    }
}
extension FilterTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(self.indexPath) 테이블 셀의 \(indexPath) 컬렉션 뷰 선택 ")
        self.delegate?.selectCategory(in: indexPath, on: self.indexPath!)
    }
}

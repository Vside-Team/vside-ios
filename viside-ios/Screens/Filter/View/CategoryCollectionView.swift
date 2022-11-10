//
//  CategoryCollectionView.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/11/02.
//

import UIKit

final class CategoryCollectionView: UICollectionView {
    init() {
        super.init(frame: .zero, collectionViewLayout: LeftAlignmentCollectionViewFlowLayout())
        self.collectionViewLayout = LeftAlignmentCollectionViewFlowLayout()
        self.isMultipleTouchEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isScrollEnabled = false
        self.backgroundColor = .clear
        self.register(KeywordCollectionViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

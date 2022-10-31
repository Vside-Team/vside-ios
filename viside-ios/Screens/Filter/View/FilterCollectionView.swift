//
//  FilterCollectionView.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import UIKit

final class FilterCollectionView: UICollectionView {
    
    init() {
        super.init(frame: .zero, collectionViewLayout: LeftAlignmentCollectionViewFlowLayout())
        self.collectionViewLayout = LeftAlignmentCollectionViewFlowLayout()
        self.isMultipleTouchEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.isScrollEnabled = false
//        self.register(.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

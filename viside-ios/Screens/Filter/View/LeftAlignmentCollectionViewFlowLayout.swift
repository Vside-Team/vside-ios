//
//  LeftAlignmentCollectionViewFlowLayout.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import UIKit

final class LeftAlignmentCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    private let interItemSpacing: CGFloat = 12
    private let lineSpacing: CGFloat = 10
    private let xInset: CGFloat = 0
    private let yInset: CGFloat = 0

    override func prepare() {
        super.prepare()
        self.configure()
    }
    private func configure() {
        self.minimumInteritemSpacing = self.interItemSpacing
        self.minimumLineSpacing = self.lineSpacing
        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
        self.scrollDirection = .vertical
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + interItemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}

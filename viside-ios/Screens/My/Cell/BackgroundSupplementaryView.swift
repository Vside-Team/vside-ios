//
//  BackgroundSupplementaryView.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/03.
//

import UIKit

final class BackgroundSupplementaryView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.g25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

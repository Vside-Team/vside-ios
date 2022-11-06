//
//  tagLabel.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/01.
//

import Foundation
import UIKit

class tagLabel : UILabel {
    private var padding = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
        
    convenience init(padding: UIEdgeInsets, tag : String) {
        self.init()
        self.padding = padding
        self.text = tag
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = Color.g100?.cgColor
        self.textColor = Color.g500
        self.font = Font.xs.medium
    }
    
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: padding))

        }
        
        override var intrinsicContentSize: CGSize {
            var contentSize = super.intrinsicContentSize
            contentSize.height += padding.top + padding.bottom
            contentSize.width += padding.left + padding.right
            
            return contentSize
        }
}

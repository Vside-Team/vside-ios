//
//  PaddingLabel.swift
//  viside-ios
//
//  Created by 김정은 on 2022/10/02.
//

import Foundation
import UIKit

class PaddingLabel : UILabel {
    private var padding = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
        
        convenience init(padding: UIEdgeInsets) {
            self.init()
            self.padding = padding
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

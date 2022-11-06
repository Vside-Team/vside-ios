//
//  String+Extension.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/11/02.
//

import UIKit

extension String {
    
    func insetSize() -> CGSize {
        let attributes: [NSAttributedString.Key : UIFont] = [.font: Font.base.regular]
        let size: CGSize = self.size(withAttributes: attributes as [NSAttributedString.Key: Any])
        return CGSize(width: size.width + 32, height: 36)
    }
}

//
//  UILabel+Extension.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import UIKit

extension UILabel {
    
    /// 기본 텍스트 스타일
    func style(typo: FontBase, font: UIFont, color: UIColor? = Color.g950) {
        let style = NSMutableParagraphStyle()

        var lineHeight: CGFloat = 0
        self.textColor = color
        self.font = font

        lineHeight = typo.lineHeight
        
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight

        let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / 2.0

        let attribute = NSMutableAttributedString(
            string: self.text ?? "",
            attributes: [
                .baselineOffset : baselineOffset,
                .paragraphStyle : style,
                .font : font,
                .foregroundColor : color
            ])
        self.attributedText = attribute
    }

}

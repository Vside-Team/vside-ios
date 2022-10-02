//
//  Font.swift
//  viside-ios
//
//  Created by 김정은 on 2022/08/12.
//

import UIKit


struct Font {
    static let xl5 = FontBase(size: .xl5)
    static let xl4 = FontBase(size: .xl4)
    static let xl3 = FontBase(size: .xl3)
    static let xl2 = FontBase(size: .xl2)
    static let xl = FontBase(size: .xl, lineHeight: .xl)
    static let lg = FontBase(size: .lg, lineHeight: .lg)
    static let base = FontBase(size: .base, lineHeight: .base)
    static let md = FontBase(size: .md, lineHeight: .md)
    static let sm = FontBase(size: .sm, lineHeight: .sm)
    static let xs = FontBase(size: .xs, lineHeight: .xs)
    static let xs2 = FontBase(size: .xs2)
}
struct FontBase {
    public var regular: UIFont
    public var medium: UIFont
    public var semiBold: UIFont
    public var bold: UIFont
    public var extraBold: UIFont
    
    public var lineHeight: CGFloat
    
    init(size: Typography.Size, lineHeight: Typography.LineHeight = .default) {
        self.regular = Utils.setMontserratSpoqa(size: size, weight: .regular)
        self.medium = Utils.setMontserratSpoqa(size: size, weight: .medium)
        self.semiBold = Utils.setMontserratSpoqa(size: size, weight: .semiBold)
        self.bold = Utils.setMontserratSpoqa(size: size, weight: .bold)
        self.extraBold = Utils.setMontserratSpoqa(size: size, weight: .extraBold)
        self.lineHeight = lineHeight.rawValue
    }
}
enum Typography {
    
    enum Size: CGFloat {
        case xl5 = 28
        case xl4 = 26
        case xl3 = 24
        case xl2 = 22
        case xl = 20
        case lg = 18
        case base = 16
        case md = 15
        case sm = 14
        case xs = 12
        case xs2 = 10
    }
    
    enum Weight {
        case regular, medium, semiBold, bold, extraBold
    }
    
    enum LineHeight: CGFloat {
        case xl = 32
        case lg = 30
        case base = 28
        case md = 27
        case sm = 26
        case xs = 22
        case `default` = 0
    }
}

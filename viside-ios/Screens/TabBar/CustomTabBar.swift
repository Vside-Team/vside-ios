//
//  CustomTabBar.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//

import UIKit

final class CustomTabBar: UITabBar {
    
    override func draw(_ rect: CGRect) {
        self.addShape()
        self.unselectedItemTintColor = .gray
        self.tintColor = .systemPink
    }
    private func addShape() {
        self.backgroundColor = .systemMint
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = createPath()
//        shapeLayer.strokeColor = UIColor.clear.cgColor
//        shapeLayer.fillColor = UIColor(named: "dark-brown-2")?.cgColor
//        shapeLayer.lineWidth = 1.0
//
//        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
//        shapeLayer.shadowRadius = 10
//        shapeLayer.shadowColor = UIColor(named: "dark-brown-2")?.cgColor
//        shapeLayer.shadowOpacity = 0.3
//
//        if let oldShapeLayer = self.shapeLayer {
//            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
//        }else{
//            self.layer.insertSublayer(shapeLayer, at: 0)
//        }
//        self.shapeLayer = shapeLayer
    }
}

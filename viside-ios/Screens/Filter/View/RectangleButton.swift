//
//  RectangleButton.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/11/06.
//

import UIKit

class RectangleButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = Font.lg.medium
//        self.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        self.deselected()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc
//    private func didTap() {
//        isSelected.toggle()
//        isSelected ? self.selected() :
//        self.deselected()
//    }
    
    func selected() {
        self.backgroundColor = Color.main500
        self.isUserInteractionEnabled = true
    }
    func deselected() {
        self.backgroundColor = Color.g200
        self.isUserInteractionEnabled = false
    }
}

//
//  BottomSheetViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/02.
//

import UIKit
import Then
import SnapKit

class BottomSheetViewController: UIViewController {
    
    lazy var handleView = UIView().then {
        $0.backgroundColor = .systemPink
//        $0.add
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

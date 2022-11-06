//
//  NavTitle.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/02.
//
import UIKit
import Then
import SnapKit

final class NavTitleView: UIView, Layout {
    let iconBtn = UIButton().then{
        $0.setImage(UIImage(named:"My/leftArrow"), for: .normal)
    }
     private let titleLabel = UILabel().then {
        $0.textColor = Color.g950
    }
    private let numLabel = UILabel().then {
       $0.textColor = Color.main500
   }
    init() {
        super.init(frame: .zero)
        self.setViews()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setViews() {
        self.addSubview(iconBtn)
        self.addSubview(numLabel)
        self.addSubview(titleLabel)
    }
    func setConstraints() {
        iconBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(26)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(23)
            $0.width.equalTo(13)
        }
        numLabel.snp.makeConstraints {
            $0.leading.equalTo(iconBtn.snp.trailing).offset(103)
            $0.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

    func setNumTitle(_ title: String) {
        self.numLabel.text = title
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    func setFont(_ font: UIFont?) {
        self.titleLabel.font = font
        self.numLabel.font = font
    }
}

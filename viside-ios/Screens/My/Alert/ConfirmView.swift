//
//  ConfirmView.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/26.
//

import Foundation
import Then
import SnapKit


protocol AlertConfirm {
    func action()
}
final class ConfirmView : UIView {
    var delegate : AlertConfirm?
    lazy var confirmView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }
    lazy var titleStack = UIStackView(arrangedSubviews: [title,yesBtn]).then {
        $0.axis = .vertical
        $0.spacing = 55.0
        $0.alignment = .center
        $0.distribution = .fillEqually
    }
    lazy var title = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = Color.g900
        $0.lineBreakMode = .byWordWrapping
        $0.font = Font.base.medium
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        $0.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.textAlignment = .center
    }
    lazy var yesBtn = UIButton().then {
        $0.setTitle("YES", for: .normal)
        $0.setTitleColor(Color.g950, for: .normal)
        $0.titleLabel?.font = Font.lg.semiBold
        $0.addTarget(self, action: #selector(tappedYesBtn), for : .touchUpInside)
    }
    var type : AlertType
    init(type : AlertType , title : String) {
        self.type = type
        super.init(frame: .zero)
        self.title.text = title
        self.backgroundColor = .clear
        self.setView()
        self.setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setView(){
        self.addSubview(confirmView)
        confirmView.addSubview(titleStack)
    }
    func setConstraints(){
        confirmView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(40)
        }
        titleStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(42)
            $0.top.equalToSuperview().offset(50)
            $0.bottom.equalToSuperview().offset(-21)
        }
       
    }
    @objc private func tappedYesBtn(){
        self.delegate?.action()
    }
}

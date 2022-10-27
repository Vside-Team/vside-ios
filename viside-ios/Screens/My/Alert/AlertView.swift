//
//  LogOutBtn.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/24.
//

import UIKit
import Then
import SnapKit

protocol AlertDelegate {
    func action()
    func cancel()
}
final class AlertView: UIView {
    var delegate : AlertDelegate?
    lazy var alertView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }
    lazy var titleStack = UIStackView(arrangedSubviews: [title,subTitle]).then {
        $0.axis = .vertical
        $0.spacing = 14.0
        $0.alignment = .center
        $0.distribution = .fillEqually
    }
    lazy var btnStack = UIStackView(arrangedSubviews: [yesBtn,noBtn]).then {
        $0.axis = .horizontal
        $0.spacing = 50.0
        $0.alignment = .center
        $0.distribution = .fillEqually
    }
    lazy var title = UILabel().then {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = Font.base.medium
        $0.textColor = Color.g900
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        $0.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.textAlignment = .center
    }
    lazy var subTitle = UILabel().then {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = Font.base.medium
        $0.textAlignment = .center
        $0.textColor = Color.g500
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        $0.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    lazy var yesBtn = UIButton().then {
        $0.setTitle("YES", for: .normal)
        $0.setTitleColor(Color.g950, for: .normal)
        $0.titleLabel?.font = Font.lg.semiBold
        $0.addTarget(self, action: #selector(tappedYesBtn), for : .touchUpInside)
    }
    lazy var noBtn = UIButton().then {
        $0.setTitle("NO", for: .normal)
        $0.setTitleColor(Color.g950, for: .normal)
        $0.titleLabel?.font = Font.lg.semiBold
        $0.addTarget(self, action: #selector(tappedNoBtn), for : .touchUpInside)
    }
    lazy var icon = UILabel().then {
        $0.textColor = Color.g200
        $0.font = Font.lg.semiBold
        $0.textAlignment = .center
        $0.attributedText = NSMutableAttributedString(string: "/", attributes: [NSAttributedString.Key.kern: -0.72])
    }
    var type: AlertType
    init(type : AlertType , title : String, subTitle : String ) {
        self.type = type
        super.init(frame: .zero)
        self.title.text = title
        self.subTitle.text = subTitle
        self.backgroundColor = .black.withAlphaComponent(0.5)
        self.setView()
        self.setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setView(){
        self.addSubview(alertView)
        let components: [Any] = [titleStack, btnStack, icon]
                components.forEach {
                    alertView.addSubview($0 as! UIView)
                }
    }
    func setConstraints(){
        alertView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(40)
        }
        titleStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(40)
            $0.top.equalToSuperview().offset(27)
        }
        btnStack.snp.makeConstraints {
            $0.centerX.equalTo(titleStack)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
            $0.top.equalTo(titleStack.snp.bottom).offset(27)
            $0.height.equalTo(44)
        }
        icon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(btnStack)
        }
    }
    @objc private func tappedYesBtn(){
        self.delegate?.action()
    }
    @objc private func tappedNoBtn(){
        self.delegate?.cancel()
    }
}

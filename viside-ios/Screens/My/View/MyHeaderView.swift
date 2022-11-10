//
//  MyHeaderView.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/11.
//

import UIKit
import Then
import SnapKit

protocol btnTappedDelegate {
    func presentVC()
}
class HeaderReusableView: UICollectionReusableView {
    static var reuseId: String = "HeaderReusableView"
    var btnDelegate : btnTappedDelegate?
    lazy var titleBtn = UIButton().then {
        $0.setTitle("전체 보기", for: .normal)
        $0.setImage(UIImage(named:"My/arrow"), for : .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setTitleColor(Color.g800, for: .normal)
        $0.titleLabel?.font = Font.sm.regular
        $0.addTarget(self, action: #selector(tappedBtn), for: .touchUpInside)
        $0.isHidden = true
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setView()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setView(){
        self.addSubview(titleBtn)
    }
    func  setConstraints(){
        titleBtn.snp.makeConstraints {
            $0.leading.equalTo(self)
            $0.top.equalTo(self).offset(17)
            $0.width.equalTo(65)
            $0.bottom.equalToSuperview()
        }
    }
    @objc func tappedBtn(){
        print("Tapped")
        self.btnDelegate?.presentVC()
    }
}



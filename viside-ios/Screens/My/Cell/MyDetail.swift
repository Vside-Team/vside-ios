//
//  MyDetail.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/01.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class MyDetail: UICollectionViewCell {
    static var reuseId: String = "MyDetail"
    var isTapped = false
    lazy var bookImage = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = Color.g200?.cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 10
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    lazy var bookMarkBtn = UIButton().then {
        $0.setImage(UIImage(named: "home/bookmark/selected"), for: .normal)
        $0.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
    }
    
     lazy var titleLabel = UILabel().then {
        $0.textColor = Color.g900
        $0.font = Font.md.medium
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.44
        $0.attributedText = NSMutableAttributedString(string: "도저히 사랑할 수 없는 세계를 \n마침내 재건하는 사람들의 마음", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    private lazy var tagStack = UIStackView(arrangedSubviews: [tagLabel0,tagLabel1,tagLabel2]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 4
    }
    lazy var tagLabel0 = tagLabel(padding: UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12), tag: "#성장").then {
        $0.backgroundColor = .white
    }
    lazy var tagLabel1 = tagLabel(padding: UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12), tag: "#성장").then {
        $0.backgroundColor = .white
    }
    lazy var tagLabel2 = tagLabel(padding: UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12), tag: "#성장").then {
        $0.backgroundColor = .white
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setViews()
        setConstrainsts()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setViews(){
        self.addSubview(bookImage)
        self.addSubview(titleLabel)
        self.addSubview(tagStack)
        bookImage.addSubview(bookMarkBtn)
    }
    func setConstrainsts(){
        bookImage.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(bookImage).offset(16)
            $0.top.equalTo(bookImage)
            $0.trailing.equalToSuperview().offset(-30)
        }
        tagStack.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(bookImage).offset(-16)
            $0.top.equalTo(titleLabel).offset(45)
        }
        bookMarkBtn.snp.makeConstraints {
            $0.leading.equalTo(bookImage).offset(20)
            $0.top.equalTo(bookImage).offset(22)
        }
    }
    func congifure(_ item : MyContentsResponse.Content){
        bookImage.kf.setImage(with: URL(string: item.img), placeholder: UIImage(systemName: "hands.sparkles.fill"))
        titleLabel.text = item.title
        if item.keywords.isEmpty == true {
            tagLabel0.isHidden = true
            tagLabel1.isHidden = true
            tagLabel2.isHidden = true
        }
        tagLabel0.text = item.keywords[0]
        tagLabel1.text = item.keywords[1]
        tagLabel2.text = item.keywords[2]
    }
    @objc func btnTapped(){
        if isTapped == true {
            bookMarkBtn.setImage(UIImage(named:  "home/bookmark/selected"), for: .normal)
            self.isTapped = false
            print("isTapped : \(isTapped)")
        }else{
            bookMarkBtn.setImage(UIImage(named: "home/bookmark/normal"), for: .normal)
            self.isTapped = true
            print("isTapped : \(isTapped)")
        }
    }
}

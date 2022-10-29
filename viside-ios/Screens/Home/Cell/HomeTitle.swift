//
//  UserCell.swift
//  viside-ios
//
//  Created by 김정은 on 2022/09/28.
//

import UIKit

class HomeTitle: UICollectionViewCell {
    static var reuseId: String = "HomeTitle"
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(titleIcon)
       
    }
  private lazy  var titleLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString(string: "Inside, V side", attributes: [NSAttributedString.Key.kern: -0.8])
        $0.numberOfLines = 0
        $0.font = Font.xl.extraBold
        $0.textColor = Color.g950
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
   private lazy var titleIcon = UIImageView().then {
        $0.image = UIImage(named: "home/title/icon")
    }
    var subTitleLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        $0.lineBreakMode = .byWordWrapping
        $0.attributedText = NSMutableAttributedString(string : "석가는 못하다 같으며, 위하여서 끊는다. 이것은 것이 그들에게 피고 품고 투명하되 더운지라 얼음 거선의 그리하였는가? 역사를 미묘한 같은 찾아다녀도, 힘차게  영원히 이것을 같은 실로 것이다. 얼음에 않는 놀이 얼마나 천자만홍이 눈에 희망의 황금시",attributes : [NSAttributedString.Key.paragraphStyle : paragraphStyle])
        $0.numberOfLines = 0
        $0.font = Font.base.regular
        $0.textColor = Color.g800
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = Color.g25
        setViews()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews(){
        self.contentView.addSubview(stackView)
        self.contentView.addSubview(subTitleLabel)
    }
    func  setConstraints(){
        stackView.snp.makeConstraints {
            $0.leading.equalTo(contentView)
            $0.top.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(137)
        }
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(stackView)
            $0.trailing.equalTo(contentView)
            $0.top.equalTo(stackView.snp.bottom).offset(16)
        }
    }
  
}



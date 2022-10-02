//
//  FoodCell.swift
//  viside-ios
//
//  Created by 김정은 on 2022/09/28.
//

import UIKit

class HomeBook: UICollectionViewCell {
    var isTapped = false
    static var reuseId: String = "HomeBook"

    private lazy var tagLabel = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 15.0, bottom: 8.0, right: 15.0)).then {
                $0.text = "몽환"
                $0.numberOfLines = 0
                $0.font = Font.base.medium
                $0.textColor = Color.g900
                $0.textAlignment = .center
                $0.numberOfLines = 0
                $0.frame = CGRect(x: 0, y: 0, width: 60 ,height: 36 )
                $0.layer.cornerRadius = 18
                $0.layer.backgroundColor = UIColor.white.cgColor
                $0.layer.borderColor = Color.g100?.cgColor
                $0.layer.borderWidth = 1.0
    }
    var textLabel = UILabel().then {
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.31
        $0.lineBreakMode = .byWordWrapping
        $0.attributedText = NSMutableAttributedString(string: "도저히 사랑할 수 없는 세계를 \n마침내 재건하는 사람들의 마음", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.numberOfLines = 0
        $0.font = Font.xl2.bold
        $0.textColor = .white
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }

   private lazy var bookMarkBtn = UIButton().then {
        $0.setImage(UIImage(named: "home/bookmark/normal"), for: .normal)
        $0.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = Color.main300
        self.layer.cornerRadius = 34
        setViews()
        setConstraints()
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setViews(){
        self.contentView.addSubview(tagLabel)
        self.contentView.addSubview(textLabel)
        self.contentView.addSubview(bookMarkBtn)
        }
    func  setConstraints(){
       
        tagLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(18)
            $0.top.equalTo(contentView).offset(20)
        }
        bookMarkBtn.snp.makeConstraints {
            $0.trailing.equalTo(contentView).offset(-20)
            $0.top.equalTo(contentView).offset(22)
        }
        textLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(28)
            $0.bottom.equalTo(contentView).offset(-24)
            $0.trailing.equalTo(contentView).offset(-43)
        }
    }
  @objc func btnTapped(){
      if isTapped == true {
          bookMarkBtn.setImage(UIImage(named: "home/bookmark/selected"), for: .normal)
          self.isTapped = false
          print("isTapped : \(isTapped)")
      }else{
          bookMarkBtn.setImage(UIImage(named: "home/bookmark/normal"), for: .normal)
          self.isTapped = true
          print("isTapped : \(isTapped)")
      }

    }
    
}

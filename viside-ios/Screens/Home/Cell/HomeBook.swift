//
//  FoodCell.swift
//  viside-ios
//
//  Created by 김정은 on 2022/09/28.
//

import UIKit
import Then
import SnapKit
import Kingfisher
import Moya
class HomeBook: UICollectionViewCell {
    var  contentID : Int!
    var scrapData : ContentScrapResponse?
    var isScrap : Bool!
    static var reuseId: String = "HomeBook"
    
    private lazy var imageView = UIImageView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 34
        $0.backgroundColor = Color.main300
        $0.contentMode = .scaleAspectFill
        
    }
    
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
        $0.layer.opacity = 0.9
        $0.layer.borderColor = Color.g100?.cgColor
        $0.layer.borderWidth = 1.0
    }
    var textLabel = UILabel().then {
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.31
        $0.lineBreakMode = .byWordWrapping
        $0.attributedText = NSMutableAttributedString(string: "도저히 사랑할 수 없는 세계를 \n마침내 재건하는 사람들의 마음", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 4
        shadow.shadowColor = Color.g500
        $0.numberOfLines = 0
        $0.font = Font.xl2.bold
        $0.textColor = .white
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    private let bookMark = UIImageView().then {
        $0.image = UIImage(named: "home/bookmark/normal")
        $0.backgroundColor = .clear
    }
    private lazy var bookMarkBtn = UIButton().then {
        $0.backgroundColor = .clear
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
        let components: [Any] = [imageView, tagLabel, textLabel,bookMarkBtn]
        components.forEach {
            self.contentView.addSubview($0 as! UIView)
        }
        self.bookMarkBtn.addSubview(bookMark)
    }
    func  setConstraints(){
        imageView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        tagLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView).offset(18)
            $0.top.equalTo(imageView).offset(20)
        }
        bookMarkBtn.snp.makeConstraints {
            $0.trailing.equalTo(imageView).offset(-20)
            $0.top.equalTo(imageView).offset(22)
        }
        textLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView).offset(28)
            $0.bottom.equalTo(imageView).offset(-24)
            $0.trailing.equalTo(imageView).offset(-43)
        }
        bookMark.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    @objc func btnTapped(_ sender : UIButton){
        print("btn Tapped")
        if isScrap == true{
            print("isScrap == true ")
            self.bookMark.image = UIImage(named: "home/bookmark/normal")
            self.bookScrap(contentId: self.contentID )
        } else {
            print ("isScrap == false")
            self.bookMark.image = UIImage(named: "home/bookmark/selected")
            self.bookScrap(contentId: self.contentID )
        }
    }
    func bookMarkStauts(status : Bool) {
        if (status == true){
           print("true")
        }else {
           print("false")
        }
    }
    func updataData(item: Content?){
        guard let item = item else{
            tagLabel.text = "V Side"
            textLabel.text = "V Side"
            return
        }
        imageView.kf.setImage(with: URL(string: item.imgURL), placeholder: UIImage(systemName: "hands.sparkles.fill"))
        tagLabel.text = item.mainKeyword
        textLabel.text = item.title
        self.contentID = item.contentId
    }
}
extension HomeBook {
    private func bookScrap(contentId : Int){
        ContentAPI().contentProvider.request(.scrap(contentId: contentId)){ response in
            switch response {
            case .success(let result):
                do{
                    let filteredResponse = try result.filterSuccessfulStatusCodes()
                    self.scrapData = try filteredResponse.map(ContentScrapResponse.self)
                    if let result = self.scrapData{
                        self.bookMarkStauts(status: result.status)
                        print("bookmark status :\(result.status)")
                       if result.status == true {
                           self.isScrap = result.status
                       }
                    }
                }catch(let error){
                    print("catch error :\(error.localizedDescription)")
                }
            case .failure(let error):
                print("failure :\(error.localizedDescription)")
            }
        }
    }
}

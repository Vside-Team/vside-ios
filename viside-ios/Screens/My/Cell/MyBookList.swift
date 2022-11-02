//
//  MyBookList.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/12.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class MyBookList: UICollectionViewCell {
    static var reuseId: String = "MyBookList"
    lazy var imageView = UIImageView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 20
        $0.backgroundColor = Color.main300
        $0.contentMode = .scaleAspectFill
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.isHidden = false
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        self.layer.shadowColor = Color.g200?.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 14
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 20
        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(_ item : MyBookListItem){
        imageView.kf.setImage(with: URL(string: item.imgURl), placeholder: UIImage(systemName: "hands.sparkles.fill"))
    }
    func setView(){
        self.addSubview(imageView)
    }
    func setConstraints(){
        imageView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
}

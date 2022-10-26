//
//  MyPageListCell.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/12.
//

import UIKit
import Then
import SnapKit

class MyPageList: UICollectionViewCell {
    static var reuseId: String = "MyPageList"
    lazy var listLabel = UILabel().then{
        $0.text = ""
        $0.font = Font.md.medium
        $0.textColor = Color.g600
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func configure(_ listItem : MyPageListItem ){
        listLabel.text = listItem.listTitle
    }
    func setViews(){
        self.contentView.addSubview(listLabel)
    }
    func setConstraints(){
        listLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(19)
            $0.centerY.equalToSuperview()
        }
    }
    
}

//
//  Empty.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/01.
//

import UIKit
import Then
import SnapKit
class Empty: UICollectionViewCell {
    static var reuseId: String = "Empty"
    private lazy var mainTitle = UILabel().then{
        $0.backgroundColor = .clear
        $0.textColor = Color.main500
        $0.textAlignment = .center
        $0.font = Font.xl.extraBold
        $0.attributedText = NSMutableAttributedString(string: "Empty...", attributes: [NSAttributedString.Key.kern: -0.8])
    }
    private lazy var iconLabel = UILabel().then {
        $0.text = "ZZ"
        $0.font = Font.xs2.extraBold
        $0.textColor = Color.main400
    }
    private lazy var subTitle = UILabel().then {
        $0.backgroundColor = .clear
        $0.font = Font.sm.regular
        $0.textColor = Color.main400
        $0.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.48
        $0.textAlignment = .center
        $0.attributedText = NSMutableAttributedString(string: "아직 북마크한 컨텐츠가 없어요.\n책장을 채워넣어보세요!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setViews()
        setConstraints()
        self.backgroundColor = Color.g25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setViews(){
        let components: [Any] = [mainTitle, iconLabel, subTitle]
        components.forEach {
            self.addSubview($0 as! UIView)
        }
    }
    func setConstraints(){
        mainTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(48)
        }
        iconLabel.snp.makeConstraints {
            $0.leading.equalTo(mainTitle.snp.trailing)
            $0.centerY.equalTo(mainTitle.snp.top)
        }
        subTitle.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(48)
        }
    }
    
}

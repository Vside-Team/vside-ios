//
//  SubView.swift
//  viside-ios
//
//  Created by 김정은 on 2022/09/28.
//

import UIKit
import Combine
import Then
import SnapKit

class SubView: UIView {
    
    @Published private (set) var username : HomeUserResponse?
    var subscriptions = Set<AnyCancellable>()
    
    private lazy  var titleLabel = UILabel().then  {
        $0.numberOfLines = 0
        $0.font = Font.xl2.medium
        $0.textColor = Color.g900
        $0.textAlignment = .left
    }
    private lazy var titleBackImage = UIImageView().then {
        $0.image = UIImage(named: "home/title/title")
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .white
        setViews()
        setConstraints()
        homeUserName()
        bind()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews(){
        self.addSubview(titleBackImage)
        self.addSubview(titleLabel)
    }
    func  setConstraints(){
        
        titleBackImage.snp.makeConstraints {
            $0.leading.equalTo(self)
            $0.top.equalTo(self).offset(52)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self).offset(20)
            $0.top.equalTo(self).offset(58)
        }
    }
    private func bind(){
        $username
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.updataData(data: result)
            }.store(in: &subscriptions)
    }
    
    func updataData(data : HomeUserResponse?){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.31
 
        guard let data = data else {
            self.titleLabel.attributedText = NSMutableAttributedString(string: "안녕하세요, V sider님!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            return
        }
        self.titleLabel.attributedText = NSMutableAttributedString(string: "안녕하세요, \(data.username)님!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
extension SubView {
    func homeUserName(){
        HomeUserAPI.shared.homeUserName { (response) in
            switch response {
            case .success(let data):
                if let data = data as? HomeUserResponse{
                    self.updataData(data: data)
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}

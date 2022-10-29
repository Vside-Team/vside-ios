//
//  MySubView.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/12.
//

import UIKit
import Combine
import Then
import SnapKit

class MySubView: UIView {
    
    @Published private (set) var username : HomeUserResponse?
    var subscriptions = Set<AnyCancellable>()
    
    private lazy  var titleLabel = UILabel().then  {
        $0.numberOfLines = 0
        $0.font = Font.xl2.extraBold
        $0.textColor = Color.g950
        $0.textAlignment = .left
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
        self.addSubview(titleLabel)
    }
    func  setConstraints(){
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self).offset(21.67)
            $0.top.equalTo(self).offset(62)
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
        guard let data = data else {
            self.titleLabel.text = "V sider's Bookshelf"
            return
        }
        self.titleLabel.text = "\(data.username)'s Bookshelf"
       
    }
}
extension MySubView {
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

//
//  SubView.swift
//  viside-ios
//
//  Created by 김정은 on 2022/09/28.
//

import UIKit
import Then
import SnapKit
import Moya

class SubView: UIView {
    var userData : HomeUserResponse?
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
   
    func updataData(data : String?){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.31
 
        guard let data = data else {
            self.titleLabel.attributedText = NSMutableAttributedString(string: "안녕하세요, V sider님!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            return
        }
        self.titleLabel.attributedText = NSMutableAttributedString(string: "안녕하세요, \(data)님!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
extension SubView {
    func homeUserName(){
        HomeAPI().homeProvider.request(.homeuserName) { response in
            switch response {
            case .success(let result):
                do{
                    let filteredResponse = try result.filterSuccessfulStatusCodes()
                    self.userData = try filteredResponse.map(HomeUserResponse.self)
                    if let result = self.userData?.username{
                        self.updataData(data: result)
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

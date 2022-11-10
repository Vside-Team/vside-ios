//
//  MySubView.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/12.
//

import UIKit
import Then
import SnapKit

class MySubView: UIView {
    var userData : HomeUserResponse?
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
        myUserName()
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
   // MARK: - update data
    func updataData(data : String?){
        guard let data = data else {
            self.titleLabel.text = "V sider's Bookshelf"
            return
        }
        self.titleLabel.text = "\(data)'s Bookshelf"
       
    }
}
// MARK: - connect user name
extension MySubView {
    func myUserName(){
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

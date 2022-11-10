//
//  AlertViewModel.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/08.
//
import Moya
import UIKit

extension AlertViewController {
    func myLogout(){
        MyAPI().myProvider.request(.logOut){ (response) in
            switch response {
            case .success(let data):
                do {
                    let filteredResponse = try data.filterSuccessfulStatusCodes()
                    let data = try filteredResponse.map(MyResponse.self)
                    print("logout data :\(data)")
                }catch(let error){
                    print("catch error :\(error.localizedDescription)")
                }
            case .failure(let error):
                print("failure :\(error.localizedDescription)")
            }
        }
    }
    func myLinkout(){
        if let snsId = UserDefaults.standard.string(forKey:Const.DefaultKeys.userId){
            MyAPI().myProvider.request(.linkOut(snsId: snsId)){ (response) in
                switch response {
                    case .success(let data):
                        do {
                            let filteredResponse = try data.filterSuccessfulStatusCodes()
                            let data = try filteredResponse.map(MyResponse.self)
                            print("link out data :\(data)")
                        }catch(let error){
                            print("catch error :\(error.localizedDescription)")
                        }
                    case .failure(let error):
                        print("failure :\(error.localizedDescription)")
                    }
                }
            }
        else {
            print("error")
        }
    }
}

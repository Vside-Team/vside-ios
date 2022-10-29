//
//  MyUserAPI.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/26.
//


import Foundation
import Moya
import Alamofire

public class  MyUserAPI{
    static let shared = MyUserAPI()
    var myUserProvider = MoyaProvider<MyUserService>(plugins : [MoyaLoggingPlugin()])
    public init() {}
    
    func myLogOut(completion: @escaping (NetworkResult<Any>) -> Void) {
        myUserProvider.request(.logOut){ (result) in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let data = try filteredResponse.map(MyResponse.self)
                    print("loginResposedata : \(data)")
                    completion(.success(data))
                    print("success login : \(data)")
                } catch let error {
                    print("login error: \(error)")
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func myLinkOut(snsId : String,completion: @escaping (NetworkResult<Any>) -> Void) {
        myUserProvider.request(.linkOut(snsId: snsId)){ (result) in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let data = try filteredResponse.map(MyResponse.self)
                    completion(.success(data))
                    print("success login : \(data)")
                } catch let error {
                    print("login error: \(error)")
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}


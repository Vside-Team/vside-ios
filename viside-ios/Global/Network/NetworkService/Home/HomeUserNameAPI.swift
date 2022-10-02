//
//  HomeUserNameAPI.swift
//  viside-ios
//
//  Created by 김정은 on 2022/09/28.
//

import Foundation
import Moya
import Alamofire

public class  HomeUserNameAPI{
    static let shared = HomeUserNameAPI()
    var homeUserProvider = MoyaProvider<HomeUserService>(plugins : [MoyaLoggingPlugin()])
    public init() {}
    
    func homeUserName(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeUserProvider.request(.homeuserName){ (result) in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let data = try filteredResponse.map(HomeUserResponse.self)
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
    }


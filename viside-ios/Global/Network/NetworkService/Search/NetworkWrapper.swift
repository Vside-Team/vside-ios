//
//  NetworkWrapper.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/11/01.
//

import Foundation
import Moya

class NetworkWrapper<Provider: TargetType>: MoyaProvider<Provider> {
    
    init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
         plugins: [PluginType]) {
        let session = MoyaProvider<Provider>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 20
        session.sessionConfiguration.timeoutIntervalForResource = 20
        super.init(endpointClosure: endpointClosure,
                   stubClosure: stubClosure,
                   session: session,
                   plugins: plugins)
    }
    
    func requestSuccessRes<Model: Codable>(target: Provider,
                                                      instance: Model.Type,
                                           completion: @escaping(Result<Model, MoyaError>) -> ()) {
        self.request(target) { result in
            switch result {
            case .success(let response):
                print("네트워크 결과 success \(response.statusCode)")
                switch response.statusCode {
                case 200..<300:
                    if let decodeData = try? JSONDecoder().decode(instance, from: response.data) {
                        completion(.success(decodeData))
                    } else {
                        completion(.failure(.requestMapping("디코딩 오류")))
                    }
                default:
                    completion(.failure(.statusCode(response)))
                }
                completion(.failure(.statusCode(response)))
            case .failure(let error):
                print("네트워크 결과 failure \(error)")
                completion(.failure(error))
            }
        }
    }
}

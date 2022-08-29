//
//  LogInResponseData.swift
//  viside-ios
//
//  Created by 김정은 on 2022/08/24.
//
import Foundation

// MARK: - LogInResponse
struct LogInResponse: Decodable {
    var memberStatus: Bool
    var jwt: String

    enum CodingKeys: String, CodingKey {
        case memberStatus = "memberStatus"
        case jwt = "jwt"
    }
    init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
          memberStatus = (try? values.decode(Bool.self, forKey: .memberStatus)) ?? false
          jwt = (try? values.decode(String.self, forKey: .jwt)) ?? ""
      }
}

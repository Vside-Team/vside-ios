//
//  HomeUserResponse.swift
//  viside-ios
//
//  Created by 김정은 on 2022/09/28.
//

import Foundation
// MARK: - HomeUserResponse
struct HomeUserResponse: Codable {
    let username: String
    enum CodingKeys: String, CodingKey {
        case username = "username"
    }
    init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
        username = (try? values.decode(String.self, forKey: .username)) ?? ""
      }
}


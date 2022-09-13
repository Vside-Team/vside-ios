//
//  SignInResponseData.swift
//  viside-ios
//
//  Created by 김정은 on 2022/08/24.
//

import Foundation

// MARK: - JoinResponse
struct JoinResponse: Codable {
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
    }
    init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
          success = (try? values.decode(Bool.self, forKey: .success)) ?? false
      }
}

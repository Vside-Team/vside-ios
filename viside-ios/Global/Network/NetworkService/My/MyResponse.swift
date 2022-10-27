//
//  myResponse.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/26.
//

import Foundation
// MARK: - MyResponse
struct MyResponse: Codable {
    let message: String
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
    init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
      }
}

//
//  BookContentsResponse.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/11.
//

import Foundation
// MARK: - ContentScrapResponse
struct ContentScrapResponse: Codable {
    let status: Bool
    let message: String
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Bool.self, forKey: .status)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
    }
}

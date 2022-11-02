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
// MARK: - MyContentsResponse
struct MyContentsResponse: Codable ,Hashable{
    let count: Int
    let contents: [Content]
    
    enum CodingKeys: String, CodingKey {
        case count
        case contents = "Contents"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = (try? values.decode(Int.self, forKey: .count)) ?? 0
        contents = (try? values.decode(Array.self, forKey: .contents)) ?? []
    }
    // MARK: - Content
    struct Content: Codable, Hashable {
        let contentID: Int
        let title, img: String
        let keywords: [String]
        let scrap: Bool
        
        enum CodingKeys: String, CodingKey {
            case contentID = "contentId"
            case title, img, keywords, scrap
        }
    }
}

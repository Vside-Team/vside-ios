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
    let contents: [Contents]
    enum CodingKeys: String, CodingKey {
        case count
        case contents = "contents"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = (try? values.decode(Int.self, forKey: .count)) ?? 0
        contents = (try? values.decode(Array.self, forKey: .contents)) ?? []
    }
}
// MARK: - Contents
struct Contents: Codable, Hashable {
    let contentID: Int
    let title, img: String
    let keywords: [String]
    let scrap: Bool
    
    enum CodingKeys: String, CodingKey {
        case contentID = "contentId"
        case title
        case img = "imgUrl"
        case keywords, scrap
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        contentID = (try? values.decode(Int.self, forKey: .contentID)) ?? 0
        title = (try? values.decode(String.self, forKey: .title)) ?? ""
        img = (try? values.decode(String.self, forKey: .img)) ?? ""
        keywords = (try? values.decode(Array.self, forKey: .keywords)) ?? []
        scrap = (try? values.decode(Bool.self, forKey: .scrap)) ?? false

    }
}


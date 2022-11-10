//
//  HomeBookList.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/18.
//

import Foundation

// MARK: - HomeBookResponse
struct HomeBookResponse: Codable,Hashable {
    let contents: [Content]
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        contents = (try? values.decode(Array.self, forKey: .contents)) ?? []
    }
}
struct Content: Codable,Hashable {
    let contentId: Int
    let title: String
    let imgURL: String
    let mainKeyword: String
    let keywords: [String]
    let scrap: Bool
    
    enum CodingKeys: String, CodingKey {
        case contentId = "contentId"
        case title
        case imgURL = "imgUrl"
        case mainKeyword,  scrap
        case keywords
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        contentId = (try? values.decode(Int.self, forKey: .contentId)) ?? 0
        title = (try? values.decode(String.self, forKey: .title)) ?? ""
        imgURL = (try? values.decode(String.self, forKey: .imgURL)) ?? ""
        mainKeyword = (try? values.decode(String.self, forKey: .mainKeyword)) ?? ""
        keywords = (try? values.decode(Array.self, forKey: .keywords)) ?? []
        scrap = (try? values.decode(Bool.self, forKey: .scrap)) ?? false
    }
}

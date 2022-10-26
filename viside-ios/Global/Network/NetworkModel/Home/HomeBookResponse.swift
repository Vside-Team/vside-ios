//
//  HomeBookList.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/10/18.
//

import Foundation

// MARK: - HomeBookResponse
//struct HomeBookResponse: Codable,Hashable {
//    let contents: [Content]
//
//    enum CodingKeys: String, CodingKey {
//        case contents = "Contents"
//    }
//}
// MARK: - Content
struct Content: Codable, Hashable {
    let contentID: Int
    let title, imgURL, mainKeyword: String
    let keywords: [String]
    let scrap: Bool

    enum CodingKeys: String, CodingKey {
        case contentID = "contentId"
        case title
        case imgURL = "imgUrl"
        case mainKeyword, keywords, scrap
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        contentID = (try? values.decode(Int.self, forKey: .contentID)) ?? 0
        title = (try? values.decode(String.self, forKey: .title)) ?? ""
        imgURL = (try? values.decode(String.self, forKey: .imgURL)) ?? ""
        mainKeyword = (try? values.decode(String.self, forKey: .mainKeyword)) ?? ""
        keywords = (try? values.decode([String].self, forKey: .keywords)) ?? [""]
        scrap = (try? values.decode(Bool.self, forKey: .scrap)) ?? false
    }
}

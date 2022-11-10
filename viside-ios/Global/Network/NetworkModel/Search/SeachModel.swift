//
//  SeachModel.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/11/01.
//

import Foundation

struct Feed: Codable {
    let contents: [Content]

    enum CodingKeys: String, CodingKey {
        case contents = "Contents"
    }
}

// MARK: - Content
//struct Content: Codable {
//    let contentID: Int
//    let title, imgURL, mainKeyword: String
//    let keywords: [String]
//    let scrap: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case contentID = "contentId"
//        case title
//        case imgURL = "imgUrl"
//        case mainKeyword, keywords, scrap
//    }
//}

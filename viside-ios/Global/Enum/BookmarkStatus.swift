//
//  BookmarkStatus.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import UIKit

enum BookmarkStatus {
    case on, off
    
    var icon: UIImage? {
        switch self {
        case .on:
            return R.image.icon.bookmark.selected()
        case .off:
            return R.image.icon.bookmark.normal()
        }
    }
}

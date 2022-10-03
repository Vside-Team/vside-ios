//
//  BookMark.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/02.
//

import UIKit

final class Bookmark: UIView, Layout {
    
    private lazy var bookmarkImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = status.icon
    }
    private var status: BookmarkStatus
    
    init(status: BookmarkStatus) {
        self.status = status
        super.init(frame: .zero)
        self.setViews()
        self.setConstraints()
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setViews() {
        self.addSubview(bookmarkImageView)
    }
    
    func setConstraints() {
        bookmarkImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    private func configure() {
        self.backgroundColor = .clear
    }
    private func updateImage() {
        self.bookmarkImageView.image = status.icon
    }
    func getStatus() -> BookmarkStatus { self.status }
    
    func normal() {
        self.status = .off
        self.updateImage()
    }
    func selected() {
        self.status = .on
        self.updateImage()
    }
    func toggle() {
        status == .off ? self.selected() : self.normal()
    }
}

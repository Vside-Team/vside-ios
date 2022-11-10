//
//  SearchTableViewCell.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import UIKit
import Then
import SnapKit

protocol SearchTableViewCellDelegate {
    func updateBookmark(on location: IndexPath)
}
final class SearchTableViewCell: UITableViewCell, ReusableView, Layout {
    private let bookImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 16
        $0.addShadow(color: Color.g200,
                     opacity: 0.4,
                     offset: CGSize(width: 0, height: 0),
                     radius: 10)
        $0.backgroundColor = Color.main300
    }
    private let bookmark = Bookmark(status: .off)
    private lazy var bookmarkButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(bookmarkDidTap), for: .touchUpInside)
    }
    private let titleLabel = UILabel()
    
    private lazy var background = UIView().then {
        $0.addSubview(bookImageView)
        $0.addSubview(bookmark)
        $0.addSubview(bookmarkButton)
        $0.addSubview(titleLabel)
    }
    
    private var location: IndexPath = IndexPath()
    var delegate: SearchTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setViews()
        self.setConstraints()
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setViews() {
        self.contentView.addSubview(background)
    }
    
    func setConstraints() {
        background.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 9, left: 20, bottom: 9, right: 15))
        }
        bookImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.size.equalTo(CGSize(width: 128, height: 148))
        }
        bookmark.snp.makeConstraints {
            $0.top.equalToSuperview().inset(2)
            $0.leading.equalToSuperview().inset(2)
        }
        bookmarkButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(2)
            $0.size.equalTo(50)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
        }
    }
    private func configure() {
        self.selectionStyle = .none
    }
    private func setTitleStyle() {
        self.titleLabel.text = "천지는 힘차게 뼈 무엇이 봄바람을 피어나기 유소년에게서 예수는 철환하였는가? 시들어 들어 같은 아니한 부패뿐이다."
        self.titleLabel.style(typo: Font.md,
                              font: Font.md.medium,
                              color: Color.g900)
        self.titleLabel.numberOfLines = 3
    }
    func bind(location: IndexPath) {
        self.location = location
        self.setTitleStyle()
        self.updateBookmarkInset()
    }
    /// bookmark icon size가 normal/selected 다름 26, 32
    private func updateBookmarkInset() {
        bookmark.snp.updateConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.leading.equalToSuperview().inset(26)
//            $0.top.equalToSuperview().inset(bookmarkYInset)
//            $0.leading.equalToSuperview().inset(bookmarkXInset)
        }
    }
    @objc
    private func bookmarkDidTap() {
        self.bookmark.toggle()
        self.updateBookmarkInset()
        self.delegate?.updateBookmark(on: location)
    }
}

//
//  MyViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//

import UIKit
import Then
import SnapKit
import SafariServices

final class MyViewController: UIViewController {
    static let background = "background-element-kind"
    let list : [MyPageListItem] = MyPageListItem.list
    let imgList : [MyBookListItem] = MyBookListItem.list
    let myBookList : MyBookList? = nil
    private lazy var headerView = HeaderView(frame: self.view.bounds).then {
        $0.backgroundColor = .clear
        $0.frame.size.height = 35
    }
    private lazy var subView = MySubView(frame : self.view.bounds).then {
        $0.frame.size.height = 108
    }
    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout()).then {
        $0.backgroundColor = .white
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        $0.register(MyPageList.self, forCellWithReuseIdentifier: MyPageList.reuseId)
        $0.register(MyBookList.self, forCellWithReuseIdentifier: MyBookList.reuseId)
        $0.isScrollEnabled = false
        $0.delegate = self
    }
    enum Sections: Int, CaseIterable ,Hashable{
        case bookList, mypageList
    }
    private lazy var dataSource: UICollectionViewDiffableDataSource<Sections, AnyHashable>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        reloadData()
        setViews()
        setConstraints()
    }
    
    func setViews(){
        let components: [Any] = [subView, headerView, collectionView]
        components.forEach {
            self.view.addSubview($0 as! UIView)
        }
    }
    func setConstraints(){
        
        subView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(108)
        }
        headerView.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(subView.snp.bottom)
            $0.height.equalTo(40)
        }
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvirnment) -> NSCollectionLayoutSection? in
            let section = Sections(rawValue: sectionIndex)!
            switch section {
            case .bookList:
                return self.MyBookListSection()
            case .mypageList:
                return self.MylistSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 32
        layout.configuration = config
        return layout
    }
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sections, AnyHashable>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let section = Sections(rawValue: indexPath.section)!
            switch section {
            case .bookList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyBookList.reuseId, for: indexPath) as! MyBookList
                cell.configure(item as! MyBookListItem )
                cell.imageView.isHidden = (indexPath.row > 23)
                return cell
            case .mypageList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageList.reuseId, for: indexPath) as! MyPageList
                cell.configure(item as! MyPageListItem )
                if indexPath.row == 4  {
                    cell.listLabel.textColor = Color.g400
                }
                return cell
            }
        })
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, AnyHashable>()
        snapshot.appendSections([.bookList,.mypageList])
        snapshot.appendItems(imgList, toSection: .bookList)
        snapshot.appendItems(list, toSection: .mypageList)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func MyBookListSection() -> NSCollectionLayoutSection {
        let spacing = 18.0
        if  imgList.count <= 6 {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.4))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalWidth(0.4))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            group.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.interGroupSpacing = spacing
            return section
        }
        else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .absolute(148))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1.0),heightDimension: .absolute(314))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item , count: 2)
                group.interItemSpacing = .fixed(18)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 20, bottom: 0, trailing: 20)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.interGroupSpacing = 20
                return section
            }
        }
    
    private func MylistSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.supplementariesFollowContentInsets = false
        return section
    }
}
extension MyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print(indexPath)
        } else {
            if indexPath.row == 0{
                let openKakao = URL(string: "https://pf.kakao.com/_xjDxabxj")
                let safariView: SFSafariViewController = SFSafariViewController(url: openKakao as! URL)
                self.present(safariView , animated: true , completion: nil)
            }
            else if indexPath.row == 1 {
                print("1")
            }
            else if indexPath.row == 2 {
                print("2")
                
            }
            else if indexPath.row == 3 {
                let logOut = AlertViewController(type: .logOut, title: AlertType.logOut.title, subTitle: AlertType.logOut.subTitle)
                logOut.modalPresentationStyle = .overFullScreen
                self.present(logOut, animated: false)
            }
            else {
                let linkOut = AlertViewController(type: .linkOut, title: AlertType.linkOut.title, subTitle: AlertType.linkOut.subTitle)
                linkOut.modalPresentationStyle = .overFullScreen
                self.present(linkOut, animated: false)
            }
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

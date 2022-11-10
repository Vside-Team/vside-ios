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
import Moya

final class MyViewController: UIViewController {

    var contents: Contents?
    var userData : HomeUserResponse?
    var contentsData : MyContentsResponse?
    var user : String?
    var text : String?
    var list : [MyPageListItem] = MyPageListItem.list
    let myBookList : MyBookList? = nil
    
// MARK: - view
    private lazy var subView = MySubView(frame : self.view.bounds).then {
        $0.frame.size.height = 108
    }
    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout()).then {
        $0.backgroundColor = .white
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        $0.delegate = self
    }
    enum Sections: Int, CaseIterable ,Hashable{
        case bookList, mypageList , empty
    }
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Sections, AnyHashable>! = nil
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDataSource()
        reloadData()
        myContents()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.g25
        setViews()
        setConstraints()
        register()
        myUserName()
    }
    private func register(){
       collectionView.register(MyPageList.self, forCellWithReuseIdentifier: MyPageList.reuseId)
       collectionView.register(MyBookList.self, forCellWithReuseIdentifier: MyBookList.reuseId)
       collectionView.register(Empty.self, forCellWithReuseIdentifier: Empty.reuseId)
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.reuseId)
    }
   
    func setViews(){
        let components: [Any] = [subView, collectionView]
        components.forEach {
            self.view.addSubview($0 as! UIView)
        }
    }
    func setConstraints(){
        
        subView.snp.makeConstraints {
            $0.leading.equalTo(safeArea)
            $0.trailing.equalTo(safeArea)
            $0.top.equalToSuperview()
            $0.height.equalTo(108)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(safeArea)
            $0.trailing.equalTo(safeArea)
            $0.top.equalTo(subView.snp.bottom)
            $0.bottom.equalTo(safeArea)
        }
    }

    // MARK: - data
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sections, AnyHashable>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item ) -> UICollectionViewCell? in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            switch section {
            case .bookList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyBookList.reuseId, for: indexPath) as! MyBookList
                cell.configure(item as! Contents)
                return cell
            case .mypageList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageList.reuseId, for: indexPath) as! MyPageList
                cell.configure(item as! MyPageListItem)
                cell.backgroundColor = .white
                if indexPath.row == 4  {
                    cell.listLabel.textColor = Color.g400
                }
                return cell
            case .empty:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Empty.reuseId, for: indexPath) as! Empty
                    return cell
            }
        })
    }
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, AnyHashable>()
        defer {
            dataSource.apply(snapshot, animatingDifferences: false)
        }
            snapshot.appendSections([.empty,.mypageList])
            snapshot.appendItems(Array(0..<1), toSection: .empty)
            snapshot.appendItems(list, toSection: .mypageList)
            dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.reuseId, for: indexPath) as? HeaderReusableView else { return UICollectionReusableView() }
                header.btnDelegate = self
                header.titleBtn.isHidden = false
                return header
        }
    }
    
    private func updateData(user : String?){
        if user == nil {
            self.text = AlertType.confirm.title
        }
        self.user = user
        self.text = "계정을 삭제하면 \(self.user!)님의\n기록이 모두 사라져요."
    }
    private func updateImg(img : [Contents]){
        var snapshot = dataSource.snapshot()
        defer {
            dataSource.apply(snapshot, animatingDifferences: false)
        }
        if !img.isEmpty {
            snapshot.deleteSections([.empty, .mypageList])
            snapshot.appendSections([.bookList])
            snapshot.appendItems(img, toSection: .bookList)
            snapshot.appendSections([.mypageList])
            snapshot.appendItems(list , toSection: .mypageList)
        }

    }
    //MARK: - layout
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, env in
            let section = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
            if section == .bookList {
                return self.MyBookListSection()
            } else if (section == .mypageList) {
                return self.MylistSection()
            } else if (section == .empty) {
                return self.EmptySection()
            } else {
                return nil
            }
        })
         layout.register(BackgroundSupplementaryView.self, forDecorationViewOfKind: "background")
                return layout
    }
    // MARK: - section layout
     func MyBookListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .absolute(148))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
         if contentsData?.count ?? 1 == 1 {
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .estimated(220))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item , count: 1 )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 20, bottom: 46, trailing: 20)
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }else if contentsData?.count ?? 2 <= 2 {
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .estimated(280))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item , count: 2 )
            group.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 20, bottom: 46, trailing: 20)
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }else if self.contentsData?.count ?? 4 <= 4 {
            let hgroupSize1 = NSCollectionLayoutSize(widthDimension: .estimated(250), heightDimension: .estimated(220))
            let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize1, subitem: item , count: 2)
            hgroup1.interItemSpacing = .fixed(18)
            let hgroupSize2 = NSCollectionLayoutSize(widthDimension: .estimated(250), heightDimension: .estimated(220))
            let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize2, subitem: item ,count: 2)
            hgroup2.interItemSpacing = .fixed(18)
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }else if  self.contentsData?.count ?? 6 <= 6 {
            let hgroupSize1 = NSCollectionLayoutSize(widthDimension: .estimated(380), heightDimension: .estimated(220))
            let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize1, subitem: item , count: 3)
            hgroup1.interItemSpacing = .fixed(18)
            let hgroupSize2 = NSCollectionLayoutSize(widthDimension: .estimated(380), heightDimension: .estimated(220))
            let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize2, subitem: item ,count: 3)
            hgroup2.interItemSpacing = .fixed(18)
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }else if  self.contentsData?.count ?? 8 <= 8 {
            let hgroupSize1 = NSCollectionLayoutSize(widthDimension: .estimated(530), heightDimension: .estimated(220))
            let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize1, subitem: item , count: 4)
            hgroup1.interItemSpacing = .fixed(18)
            let hgroupSize2 = NSCollectionLayoutSize(widthDimension: .estimated(530), heightDimension: .estimated(220))
            let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize2, subitem: item ,count: 4)
            hgroup2.interItemSpacing = .fixed(18)
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }else if self.contentsData?.count ?? 10 <= 10 {
            let hgroupSize1 = NSCollectionLayoutSize(widthDimension: .estimated(680), heightDimension: .estimated(220))
            let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize1, subitem: item , count: 5)
            hgroup1.interItemSpacing = .fixed(18)
            let hgroupSize2 = NSCollectionLayoutSize(widthDimension: .estimated(680), heightDimension: .estimated(220))
            let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize2, subitem: item ,count: 5)
            hgroup2.interItemSpacing = .fixed(18)
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }else if  self.contentsData?.count ?? 12 <= 12 {
            let hgroupSize1 = NSCollectionLayoutSize(widthDimension: .estimated(830), heightDimension: .estimated(220))
            let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize1, subitem: item , count: 6)
            hgroup1.interItemSpacing = .fixed(18)
            let hgroupSize2 = NSCollectionLayoutSize(widthDimension:  .estimated(830), heightDimension: .estimated(220))
            let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize2, subitem: item ,count: 6)
            hgroup2.interItemSpacing = .fixed(18)
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }else if self.contentsData?.count ?? 14 <= 14 {
            let hgroupSize1 = NSCollectionLayoutSize(widthDimension:  .estimated(980) ,heightDimension: .estimated(220))
            let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize1, subitem: item , count: 7)
            hgroup1.interItemSpacing = .fixed(18)
            let hgroupSize2 = NSCollectionLayoutSize(widthDimension:  .estimated(980), heightDimension: .estimated(220))
            let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize2, subitem: item ,count: 7)
            hgroup2.interItemSpacing = .fixed(18)
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }else if self.contentsData?.count ?? 16 <= 16 {
            let hgroupSize1 = NSCollectionLayoutSize(widthDimension:.estimated(1130), heightDimension: .estimated(220))
            let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize1, subitem: item , count: 8)
            hgroup1.interItemSpacing = .fixed(18)
            let hgroupSize2 = NSCollectionLayoutSize(widthDimension: .estimated(1130), heightDimension: .estimated(220))
            let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize2, subitem: item ,count: 8)
            hgroup2.interItemSpacing = .fixed(18)
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }else if self.contentsData?.count ?? 18  <= 18 {
            let hgroupSize1 = NSCollectionLayoutSize(widthDimension:.estimated(1250), heightDimension: .estimated(220))
            let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize1, subitem: item , count: 9)
            hgroup1.interItemSpacing = .fixed(18)
            let hgroupSize2 = NSCollectionLayoutSize(widthDimension: .estimated(1250), heightDimension: .estimated(220))
            let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize2, subitem: item ,count: 9)
            hgroup2.interItemSpacing = .fixed(18)
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }else if self.contentsData?.count ?? 20  <= 20 {
            let hgroupSize1 = NSCollectionLayoutSize(widthDimension: .estimated(1430) , heightDimension: .estimated(220))
            let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize1, subitem: item , count: 10)
            hgroup1.interItemSpacing = .fixed(18)
            let hgroupSize2 = NSCollectionLayoutSize(widthDimension: .estimated(1430), heightDimension: .estimated(220))
            let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize2, subitem: item ,count: 10)
            hgroup2.interItemSpacing = .fixed(18)
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        } else if self.contentsData?.count ?? 22  <= 22 {
            let hgroupSize1 = NSCollectionLayoutSize(widthDimension:.estimated(1580), heightDimension: .estimated(220))
            let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize1, subitem: item , count: 11)
            hgroup1.interItemSpacing = .fixed(18)
            let hgroupSize2 = NSCollectionLayoutSize(widthDimension: .estimated(1580), heightDimension: .estimated(220))
            let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize2, subitem: item ,count: 11)
            hgroup2.interItemSpacing = .fixed(18)
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }else {
            let hgroupSize1 = NSCollectionLayoutSize(widthDimension: .estimated(1730), heightDimension: .estimated(220))
            let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize1, subitem: item , count: 12)
            hgroup1.interItemSpacing = .fixed(18)
            let hgroupSize2 = NSCollectionLayoutSize(widthDimension: .estimated(1730), heightDimension: .estimated(220))
            let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: hgroupSize2, subitem: item ,count: 12)
            hgroup2.interItemSpacing = .fixed(18)
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            section.decorationItems = [backgroundItem]
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }
    }

     func MylistSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.supplementariesFollowContentInsets = false
        return section
    }
     func EmptySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem : item ,count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.supplementariesFollowContentInsets = false
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        section.decorationItems = [backgroundItem]
        return section
    }
}
// MARK: - list
extension MyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print(indexPath)
        } else {
            if indexPath.row == 0{
                let openKakao = URL(string: "https://pf.kakao.com/_xjDxabxj")
                let safariView: SFSafariViewController = SFSafariViewController(url: openKakao!)
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
                let linkOut = AlertViewController(type: .linkOut, title: self.text ?? AlertType.linkOut.title , subTitle: AlertType.linkOut.subTitle)
                linkOut.modalPresentationStyle = .overFullScreen
                self.present(linkOut, animated: false)
            }
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}
extension MyViewController : btnTappedDelegate {
    func presentVC() {
        Utils.push(nav: self.navigationController, vc: MyDetailViewController())
    }
}
// MARK: - connect network
extension MyViewController {
    func myUserName(){
        HomeAPI().homeProvider.request(.homeuserName) { response in
            switch response {
            case .success(let result):
                do{
                    let filteredResponse = try result.filterSuccessfulStatusCodes()
                    self.userData = try filteredResponse.map(HomeUserResponse.self)
                    if let result = self.userData?.username{
                        self.updateData(user : result)
                    }
                }catch(let error){
                    print("catch error :\(error.localizedDescription)")
                }
            case .failure(let error):
                print("failure :\(error.localizedDescription)")
            }
        }
    }
    func myContents(){
        MyAPI().myProvider.request(.content) { response in
                switch response {
                case .success(let result):
                    do{
                        let filteredResponse = try result.filterSuccessfulStatusCodes()
                        self.contentsData = try filteredResponse.map(MyContentsResponse.self)
                        if let result = self.contentsData?.contents{
                            self.updateImg(img: result)
                        }
                    }catch(let error){
                        print("catch error :\(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("failure :\(error.localizedDescription)")
                }
            }
        }
    }

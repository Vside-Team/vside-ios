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
import Combine

final class MyViewController: UIViewController {
    @Published private (set) var username : HomeUserResponse?
    @Published private (set) var contentsImage : MyContentsResponse?
    var subscriptions = Set<AnyCancellable>()
    var list : [MyPageListItem] = MyPageListItem.list
    let imgList : [MyBookListItem] = MyBookListItem.list
    let myBookList : MyBookList? = nil
    let alertView : AlertView? = nil
    private lazy var headerView = HeaderView(frame: self.view.bounds).then {
        $0.backgroundColor = Color.g25
        $0.frame.size.height = 35
    }
    private lazy var subView = MySubView(frame : self.view.bounds).then {
        $0.frame.size.height = 108
    }
    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout()).then {
        $0.backgroundColor = Color.g25
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        $0.register(MyPageList.self, forCellWithReuseIdentifier: MyPageList.reuseId)
        $0.register(MyBookList.self, forCellWithReuseIdentifier: MyBookList.reuseId)
        $0.register(Empty.self, forCellWithReuseIdentifier: Empty.reuseId)
        $0.isScrollEnabled = false
        $0.delegate = self
    }
    enum Sections: Int, CaseIterable ,Hashable{
        case bookList, mypageList , empty
    }
    private lazy var dataSource: UICollectionViewDiffableDataSource<Sections, AnyHashable>! = nil
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.g25
        setViews()
        setConstraints()
        setupDataSource()
        reloadData()
        homeUserName()
        bind()
        self.headerView.delegate = self
    }
    private func bind(){
        $username
            .receive(on: RunLoop.main)
            .print()
            .sink { [unowned self]user in
                self.updataData(data: user)
            }
            .store(in: &subscriptions)
    }
    func updataData(data : HomeUserResponse?){
        guard let data = data else {
            print("data :\(String(describing: data))")
            self.alertView?.title.text = "AlertType.linkOut.title"
            return
        }
        self.alertView?.title.text = "계정을 삭제하면 \(data.username)님의\n기록이 모두 사라져요."
    }

    func setViews(){
        let components: [Any] = [subView, headerView, collectionView]
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
        headerView.snp.makeConstraints {
            $0.leading.equalTo(safeArea).offset(20)
            $0.trailing.equalTo(safeArea)
            $0.top.equalTo(subView.snp.bottom)
            $0.height.equalTo(40)
        }
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(safeArea)
            $0.trailing.equalTo(safeArea)
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalTo(safeArea)
        }
    }

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
                return layout
    }
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sections, AnyHashable>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            switch section {
            case .bookList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyBookList.reuseId, for: indexPath) as! MyBookList
                cell.configure(item as! MyBookListItem)
                return cell
            case .mypageList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageList.reuseId, for: indexPath) as! MyPageList
                cell.configure(item as! MyPageListItem )
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
            dataSource.apply(snapshot)
        }
        guard !imgList.isEmpty else {
        snapshot.appendSections([.empty,.mypageList])
            snapshot.appendItems(Array(0..<1), toSection: .empty)
              snapshot.appendItems(list, toSection: .mypageList)
            return
        }
        headerView.titleBtn.isHidden = false
        snapshot.appendSections([.bookList,.mypageList])
        snapshot.appendItems(imgList, toSection: .bookList)
        snapshot.appendItems(list, toSection: .mypageList)
    }
    
    private func MyBookListSection() -> NSCollectionLayoutSection {
        let spacing = 18.0
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .absolute(148))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        if imgList.count <= 1 {
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .estimated(220))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item , count: 1 )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 20, bottom: 46, trailing: 20)
            return section
        }else if imgList.count <= 2 {
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .estimated(280))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item , count: 2 )
            group.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 20, bottom: 46, trailing: 20)
            return section
        }else if imgList.count <= 4 {
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
            return section
        }else if  imgList.count <= 6 {
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
            return section
        }else if  imgList.count <= 8 {
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
            return section
        }else if  imgList.count <= 10 {
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
            return section
        }else if  imgList.count <= 12 {
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
            return section
        }else if  imgList.count <= 14 {
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
            return section
        }else if  imgList.count <= 16 {
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
            return section
        }else if  imgList.count <= 18 {
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
            return section
        }else if  imgList.count <= 20 {
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
            return section
        } else if  imgList.count <= 22 {
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
    private func EmptySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(160))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem : item ,count: 1)
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
                print(alertView?.title)
                let linkOut = AlertViewController(type: .linkOut, title: self.alertView?.title.text ?? AlertType.linkOut.title, subTitle: AlertType.linkOut.subTitle)
                linkOut.modalPresentationStyle = .overFullScreen
                self.present(linkOut, animated: false)
            }
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}
extension MyViewController {
        func homeUserName(){
            HomeUserAPI.shared.homeUserName { (response) in
                switch response {
                case .success(let data):
                    if let data = data as? HomeUserResponse{
                        self.username = data
                        self.updataData(data: data)
                        print(data)
                    }
                case .requestErr(let message):
                    print("requestErr", message)
                case .pathErr:
                    print(".pathErr")
                case .serverErr:
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                }
            }
        }
    }
extension MyViewController: btnDelegate {
    func presentVC() {
       
    }
}


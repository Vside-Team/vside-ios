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
    var subscriptions = Set<AnyCancellable>()
    static let background = "background-element-kind"
    var list : [MyPageListItem] = MyPageListItem.list
    let imgList : [MyBookListItem] = MyBookListItem.list
    let myBookList : MyBookList? = nil
    let alertView : AlertView? = nil
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
        homeUserName()
        bind()
    }
    private func bind(){
        $username
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.updataData(data: result)
            }.store(in: &subscriptions)
    }

    func updataData(data : HomeUserResponse?){
        guard let data = data else {
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
               // cell.imageView.isHidden = (indexPath.row > 23)
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(128), heightDimension: .absolute(148))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 13)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(850),heightDimension: .absolute(148))
        let verticalItemSize = NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .absolute(148))
        let verticalItem = NSCollectionLayoutItem(layoutSize: verticalItemSize)
        verticalItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 13)
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(128), heightDimension: .absolute(296))
        let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item , count: 6)
        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item , count: 6)
        let vgroup1 = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: verticalItem , count: 2)
        let vgroup2 = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: verticalItem , count: 2)
        let vgroup3 = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: verticalItem , count: 2)
        let vgroup4 = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: verticalItem , count: 2)
        let vgroup5 = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: verticalItem , count: 2)
        if imgList.count <= 6 {
            let section = NSCollectionLayoutSection(group: group1)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 2)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return section
        } else if imgList.count <= 12{
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [group1,group2])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 2)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return section
        }else {
            let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [group1,group2])
            let containerGroup1 =  NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [containerGroup,vgroup1,vgroup2,vgroup3,vgroup4,vgroup5])
            containerGroup.interItemSpacing = .fixed(18)
            let section = NSCollectionLayoutSection(group: containerGroup1)
            section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 2)
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
            
                let linkOut = AlertViewController(type: .linkOut, title: self.alertView?.title.text ?? AlertType.linkOut.title, subTitle: AlertType.linkOut.subTitle)
                linkOut.modalPresentationStyle = .overFullScreen
                self.present(linkOut, animated: false)
            }
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
extension MyViewController {
    func homeUserName(){
        HomeUserAPI.shared.homeUserName { [self] (response) in
            switch response {
            case .success(let data):
                if let data = data as? HomeUserResponse{
                    self.updataData(data: data)
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

//
//  HomeViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//

import UIKit
import Then
import SnapKit
import Moya

final class HomeViewController: UIViewController {
    var bookData: HomeBookResponse?
    var contents : Content?
    var isScrap : Bool!
    typealias Item = AnyHashable
    enum Sections: Int, CaseIterable, Hashable {
        case titleList, bookList
    }
    var dataSource: UICollectionViewDiffableDataSource<Sections, Item>! = nil
    
    // MARK: - view
    private lazy var subView = SubView(frame : self.view.bounds).then {
        $0.frame.size.height = 108
    }
    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout()).then {
        $0.backgroundColor = Color.g25
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        $0.register(HomeTitle.self, forCellWithReuseIdentifier: HomeTitle.reuseId)
        $0.register(HomeBook.self, forCellWithReuseIdentifier: HomeBook.reuseId)
        $0.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDataSource()
        reloadData()
        homeBookList()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        toastMessage(withDuration: 2.0, delay: 0)
    }
    
    func setViews(){
        view.addSubview(subView)
        view.addSubview(collectionView)
    }
    func setConstraints(){
        subView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(108)
        }
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(self.subView.snp.bottom)
            $0.bottom.equalToSuperview()
        }  
    }
   // MARK: - data
     func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sections, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let section = Sections(rawValue: indexPath.section)!
            switch section {
            case .titleList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTitle.reuseId, for: indexPath) as! HomeTitle
                return cell
                
            case .bookList:
                if let content = item as? Content {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBook.reuseId, for: indexPath) as! HomeBook
                    cell.updataData(item: content)
                    return cell
                }else { return nil}
            }
        })
    }
   private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Item>()
        snapshot.appendSections([.titleList,.bookList])
        snapshot.appendItems([], toSection: .bookList)
        snapshot.appendItems(Array(1..<2), toSection: .titleList)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    private func updateData(item : [Content]){
       print("item : \(item)")
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(item, toSection: .bookList)
        dataSource.apply(snapshot)
    }
   
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvirnment) -> NSCollectionLayoutSection? in
            let section = Sections(rawValue: sectionIndex)!
            switch section {
            case .titleList:
                return self.titleListSection()
            case .bookList:
                return self.bookListSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 32
        layout.configuration = config
        
        return layout
    }
    // MARK: - layout
    private func titleListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let spacing = CGFloat(20)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: spacing, bottom: 0, trailing: spacing)
        
        return section
    }
    
    private func bookListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(408))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 0, leading: 20, bottom: 30, trailing: 20)
        section.supplementariesFollowContentInsets = false
        return section
    }
}
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
            Utils.push(nav: self.navigationController, vc: DetailViewController())
    }
}
    
// MARK: - connect home network
extension HomeViewController{
    func homeBookList(){
        HomeAPI().homeProvider.request(.homeBookList){ (response) in
            switch response {
            case .success(let result):
                    do {
                        let filteredResponse = try result.filterSuccessfulStatusCodes()
                        self.bookData = try filteredResponse.map(HomeBookResponse.self)
                        if let result = self.bookData?.contents {
                            print("update data :\(result)")
                                self.updateData(item: result)
                        }
                        if let data = self.contents?.contentId{
                            print("result contend id:\(data)")
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

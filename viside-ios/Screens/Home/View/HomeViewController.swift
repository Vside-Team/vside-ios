//
//  HomeViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//

import UIKit
import Then
import SnapKit
import Combine

final class HomeViewController: UIViewController {
    @Published var contents : [Content] = []
    var subscriptions = Set<AnyCancellable>()
    typealias Item = AnyHashable
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

    enum Sections: Int, CaseIterable, Hashable {
        case titleList, bookList
    }
    var dataSource: UICollectionViewDiffableDataSource<Sections, Item>! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        reloadData()
        setViews()
        setConstraints()
        bind()
        homeBook()
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
   
    private func setupDataSource() {
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
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Item>()
        snapshot.appendSections([.titleList,.bookList])
        snapshot.appendItems([], toSection: .bookList)
        snapshot.appendItems(Array(1..<2), toSection: .titleList)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    private func updateData( item : [Content]){
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(item, toSection: .bookList)
        dataSource.apply(snapshot)
    }
    private func bind(){
        $contents
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
               self.updateData(item: result)
            }.store(in: &subscriptions)
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
    }
}
extension HomeViewController{
    func homeBook(){
        HomeUserAPI.shared.homeBookList { (response) in
            switch response {
            case .success(let data):
                if let data = data as? [Content]{
                    self.contents = data
                    print("\(self.contents)")
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
extension HomeViewController {
    
    func toastMessage( withDuration: Double, delay: Double){
        lazy var toastMessage = PaddingLabel(padding: UIEdgeInsets(top: 17, left: 31, bottom: 15, right: 31)).then {
            $0.frame = CGRect(x: 0, y: 0, width: 260, height: 56)
            $0.alpha = 0.8
            $0.layer.backgroundColor = Color.main500?.cgColor
            $0.layer.cornerRadius = 16
            $0.textColor = .white
            $0.font = Font.xl.extraBold
            let shadow = NSShadow()
            shadow.shadowBlurRadius = 4
            shadow.shadowColor = Color.g500
            $0.attributedText = NSMutableAttributedString(string: "Welcome to V side!", attributes: [NSAttributedString.Key.kern: -0.8, .shadow : shadow])
        }
        self.view.addSubview(toastMessage)
        
            toastMessage.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(65)
                $0.top.equalToSuperview().offset(394)
                $0.height.equalTo(56)
                $0.width.equalTo(260)
                
            }
            
            UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
                toastMessage.alpha = 0.0

               }, completion: {(isCompleted) in
                   toastMessage.removeFromSuperview()
               })

        }
      
}

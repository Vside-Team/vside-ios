//
//  HomeViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//

import UIKit

final class HomeViewController: UIViewController {
   
    private lazy var subView = SubView(frame : self.view.bounds).then {
        $0.frame.size.height = 108
    }
    
    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout()).then {
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        $0.register(HomeTitle.self, forCellWithReuseIdentifier: HomeTitle.reuseId)
        $0.register(HomeBook.self, forCellWithReuseIdentifier: HomeBook.reuseId)
        $0.delegate = self
    }

    enum Sections: Int, CaseIterable {
        case titleList, bookList
    }
    var dataSource: UICollectionViewDiffableDataSource<Sections, Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        reloadData()
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
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sections, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, intValue) -> UICollectionViewCell? in
            let section = Sections(rawValue: indexPath.section)!
            switch section {
            case .titleList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTitle.reuseId, for: indexPath) as! HomeTitle
                return cell
                
            case .bookList:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBook.reuseId, for: indexPath) as! HomeBook
                return cell
                
            }
        })
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Int>()
        snapshot.appendSections([.titleList,.bookList])
        snapshot.appendItems(Array(1..<8), toSection: .bookList) // array(1..<8) 가 section에 item으로 들어감
        snapshot.appendItems(Array(1..<2), toSection: .titleList)
        dataSource.apply(snapshot, animatingDifferences: false)
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
extension HomeViewController {
    
    func toastMessage( withDuration: Double, delay: Double){
             lazy var toastMessage = PaddingLabel(padding: UIEdgeInsets(top: 17, left: 31, bottom: 15, right: 31)).then {
                $0.frame = CGRect(x: 0, y: 0, width: 260, height: 56)
                $0.alpha = 0.8
                $0.layer.backgroundColor = Color.main500?.cgColor
                $0.layer.cornerRadius = 16
                 $0.textColor = .white
                 $0.font = Font.xl.extraBold
                 $0.attributedText = NSMutableAttributedString(string: "Welcome to Vi side!", attributes: [NSAttributedString.Key.kern: -0.8])
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
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

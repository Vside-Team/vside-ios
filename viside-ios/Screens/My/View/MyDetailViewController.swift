//
//  MyDetailViewController.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/01.
//

import UIKit
import Then
import SnapKit
import Combine

class MyDetailViewController: UIViewController {
    let navTitle  = NavTitleView().then {
        $0.setTitle("Books")
        $0.setNumTitle("1")
        $0.setFont(Font.xl2.extraBold)
        $0.iconBtn.addTarget(self, action: #selector(buttonDidTap), for : .touchUpInside)
    }
    @objc
    private func buttonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    @Published private (set) var contents : [MyContentsResponse.Content] = []
    var myDetail : MyDetail!
    var subscriptions = Set<AnyCancellable>()

    var dataSource : UICollectionViewDiffableDataSource<Section, Item>!
    typealias Item = MyContentsResponse.Content
    enum Section{
        case main
    }
    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout()).then {
        $0.backgroundColor = .white
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        $0.register(MyDetail.self, forCellWithReuseIdentifier: MyDetail.reuseId)
        $0.delegate = self
    }
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        setViews()
        setConstraints()
        setupDataSource()
        reloadData()
        bind()
        myContents()
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setViews(){
        self.view.addSubview(navTitle)
        self.view.addSubview(collectionView)
    }
    func setConstraints(){
        navTitle.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(64)
        }
        collectionView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.top.equalTo(navTitle.snp.bottom)
            $0.bottom.equalTo(safeArea)
        }
    }
   
    private func  setupDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section , Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyDetail.reuseId, for: indexPath) as? MyDetail  else { return nil}
            return cell
        })
    }
    private func reloadData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems([], toSection: .main)
        dataSource.apply(snapshot)
    }
    func bind(){
        $contents
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.updataData(data: result)
            }.store(in: &subscriptions)
    }
    func updataData(data:  [MyContentsResponse.Content] ){
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(data, toSection: .main)
        dataSource.apply(snapshot)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 9, leading: 20, bottom: 9, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
extension MyDetailViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
extension MyDetailViewController {
    func myContents(){
        MyUserAPI.shared.myContents { (response) in
            switch response {
            case .success(let data):
                if let data = data as? [MyContentsResponse.Content]{
                    self.contents = data
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

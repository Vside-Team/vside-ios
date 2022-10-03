//
//  SearchViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/09/13.
//

import UIKit

final class SearchViewController: ParentMainViewController, Layout {
    
    private lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.register(SearchTableViewCell.self)
    }
    
    private lazy var filter = FilterViewController().then {
        $0.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.setConstraints()
        self.configure()
    }
    
    func setViews() {
        self.view.addSubview(tableView)
        self.view.addSubview(filter.view)
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
        filter.view.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.bottom).inset(52)
            $0.leading.trailing.bottom.equalTo(safeArea)
        }
    }
    private func configure() {
        self.navigationView.setTitle(Strings.Search.Main.title)
    }
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SearchTableViewCell
        cell.bind(location: indexPath)
        cell.delegate = self
        return cell
    }
}
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
    }
}
extension SearchViewController: SearchTableViewCellDelegate {
    func updateBookmark(on location: IndexPath) {
        // 데이터 업데이트
    }
}
extension SearchViewController: FilterViewControllerDelegate {
    func showFilter() {
        self.filter.view.snp.updateConstraints {
            $0.top.equalTo(safeArea.snp.bottom).inset(UIScreen.main.bounds.height - 134)
        }
        Utils.layoutAnimate(self)
    }
    func hideFilter() {
        self.filter.view.snp.updateConstraints {
            $0.top.equalTo(safeArea.snp.bottom).inset(52)
        }
        Utils.layoutAnimate(self)
    }
}

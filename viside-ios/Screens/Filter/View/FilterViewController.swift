//
//  FilterViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

protocol FilterViewControllerDelegate {
    func showFilter()
    func hideFilter()
}
final class FilterViewController: UIViewController, Layout {
    
    private let barView = UIView().then {
        $0.backgroundColor = Color.main400
        $0.layer.cornerRadius = 3
    }
    private lazy var openLabel = UILabel().then {
        $0.text = Strings.Search.Filter.open
        $0.font = Font.sm.semiBold
        $0.textColor = Color.main500
    }
    
    private lazy var handle = UIView().then {
        $0.backgroundColor = Color.g25
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.addShadow(color: Color.g500,
                     opacity: 0.1,
                     offset: CGSize(width: 1, height: -3),
                     radius: 10)
        $0.addSubview(barView)
        $0.addSubview(openLabel)
        let up = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        up.direction = .up
        $0.addGestureRecognizer(up)
        let down = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        down.direction = .down
        $0.addGestureRecognizer(down)
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
    }
    private lazy var titleLabel = UILabel().then {
        $0.text = Strings.Search.Filter.title
        $0.font = Font.xl2.bold
        $0.textColor = Color.g900
    }
    private lazy var descriptionLabel = UILabel().then {
        $0.text = Strings.Search.Filter.description
        $0.font = Font.lg.regular
        $0.textColor = Color.g700
    }
    private let lineView = UIView().then {
        $0.backgroundColor = Color.g50
    }
    private lazy var titleView = UIView().then {
        $0.backgroundColor = Color.g25
        $0.addSubview(titleLabel)
        $0.addSubview(descriptionLabel)
        $0.addSubview(lineView)
    }
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = Color.g25
        $0.separatorStyle = .none
        $0.register(FilterTableViewCell.self)
        $0.dataSource = self
    }
    private lazy var doneButton = RectangleButton(title: Strings.Search.Filter.done)
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    var delegate: FilterViewControllerDelegate?
    
    private let viewModel = FilterViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.setConstraints()
        self.configure()
        self.bind()
    }
    func setViews() {
        self.view.addSubview(handle)
        self.view.addSubview(titleView)
        self.view.addSubview(tableView)
        self.view.addSubview(doneButton)
    }
    
    func setConstraints() {
        handle.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(52)
        }
        barView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 60, height: 6))
        }
        openLabel.snp.makeConstraints {
            $0.top.equalTo(barView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(handle.snp.bottom).offset(-2)
            $0.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(88)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(26)
            $0.height.equalTo(28)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(27)
            $0.height.equalTo(23)
        }
        lineView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.equalTo(safeArea)
            $0.bottom.equalTo(doneButton.snp.top)
        }
        doneButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(safeArea)
            $0.height.equalTo(60)
        }
    }
    private func configure() {
        self.view.backgroundColor = .clear
    }
    private func bind() {
        self.viewModel.output.showOpen?
            .drive(onNext: {
                self.openLabel.isHidden = $0
            })
            .disposed(by: disposeBag)
        self.viewModel.output.reload?
            .drive(onNext: {
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        self.viewModel.output.isCategorySelected?
            .drive(onNext: {
                $0 == true ? self.doneButton.selected() : self.doneButton.deselected()
            })
            .disposed(by: disposeBag)
        // 완료 비활
    }
    func bind(categories: [String]) {
        self.viewModel.input.selectedCategoryObserver.onNext(categories)
    }
}
extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.output.numberOfData
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as FilterTableViewCell
        cell.bind(self.viewModel.output.data[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}
// MARK: - 애니메이션
extension FilterViewController {
    private func expand() {
        self.delegate?.showFilter()
        self.viewModel.changeState(.expanded)
    }
    private func collapse() {
        self.delegate?.hideFilter()
        self.viewModel.changeState(.collapsed)
    }
    @objc
    private func tapGesture() {
        self.viewModel.output.state == .expanded ? self.collapse() : self.expand()
    }
    @objc
    private func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .up:
                self.expand()
            case .down:
                self.collapse()
            default:
                break
            }
        }
    }
}
extension FilterViewController: SelectFilterDelegate {
    func selectCategory(in collectionIndexPath: IndexPath, on tableIndexPath: IndexPath) {
        self.viewModel.input.selectedIndexObserver.onNext((collectionIndexPath, tableIndexPath))
    }
}

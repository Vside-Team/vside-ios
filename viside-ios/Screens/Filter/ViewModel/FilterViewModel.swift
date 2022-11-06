//
//  FilterViewModel.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import Foundation
import RxSwift
import RxCocoa

final class FilterViewModel: ViewModelType {
    var input: Input
    var output: Output
    
    private let disposeBag = DisposeBag()
    
    private let data: [Keyword] = [
        Keyword(category: ["분위기"], keywords: ["다채로운", "여름"]),
        Keyword(category: ["장르"], keywords: ["에세이", "SF", "몽환", "야경", "책방", "성장", "친구", "꿈"]),
        Keyword(category: ["소재"], keywords: ["폭력", "우울증", "인생의 지혜"]),
        Keyword(category: ["국가"], keywords: ["이집트", "비", "친구", "비", "친구", "비", "친구", "비", "친구", "비", "친구", "비", "친구", "비", "친구", "비", "친구", "다채로운", "여름"])
    ]
    private var stateObserver = BehaviorSubject<CardState>(value: .collapsed)
    private var selectedIndexObserver = PublishSubject<(collection: IndexPath, table: IndexPath)>()
    private var selectedCategoryObserver = PublishSubject<[String]>()
    init() {
        self.input = Input(stateObserver: stateObserver.asObserver(),
                           selectedIndexObserver: selectedIndexObserver.asObserver(),
                           selectedCategoryObserver: selectedCategoryObserver.asObserver())
        self.output = Output()
        self.bind()
    }
    private func bind() {
        self.output.showOpen = stateObserver
            .map(showOpenLabel)
            .asDriver(onErrorJustReturn: false)
        self.stateObserver
            .subscribe(onNext: {
                self.output.state = $0
            })
            .disposed(by: disposeBag)
        
        self.selectedCategoryObserver
            .subscribe(onNext: {
                self.output.selectedCategories.isEmpty ? (self.output.selectedCategories = $0) : self.output.selectedCategories.append(contentsOf: $0)
            })
            .disposed(by: disposeBag)
        self.output.reload = self.selectedCategoryObserver
            .map(reload)
            .asDriver(onErrorJustReturn: ())
        self.output.isCategorySelected = self.selectedCategoryObserver
            .map(checkForSelectedCategories)
            .asDriver(onErrorJustReturn: false)
        
        self.selectedIndexObserver
            .map(getSelectCategory)
            .subscribe(onNext: {
                self.selectedCategoryObserver.onNext($0)
            })
            .disposed(by: disposeBag)
        self.output.data = self.data
    }
    private func checkForSelectedCategories(_ categories: [String]) -> Bool {
        return !categories.isEmpty
    }
    private func reload(_ category: [String]) { }
    private func getSelectCategory(in collectionIndexPath: IndexPath, on tableIndexPath: IndexPath) -> [String] {
        if let categories = self.data[tableIndexPath.row].keywords?[collectionIndexPath.row] {
            return [categories]
        }
        return []
    }
}
extension FilterViewModel {
    private func showOpenLabel(state: CardState) -> Bool {
        !(state == .collapsed)
    }
}
extension FilterViewModel {
    struct Input {
        var stateObserver: AnyObserver<CardState>
        var selectedIndexObserver: AnyObserver<(collection: IndexPath, table: IndexPath)>
        var selectedCategoryObserver: AnyObserver<[String]>
    }
    struct Output {
        var showOpen: Driver<Bool>?
        var state: CardState = .collapsed
        var data: [Keyword] = []
        var numberOfData: Int {
            self.data.count
        }
        var selectedCategories: [String] = []
        var isCategorySelected: Driver<Bool>?
        var reload: Driver<Void>?
    }
    func changeState(_ state: CardState) {
        self.input.stateObserver.onNext(state)
    }
}

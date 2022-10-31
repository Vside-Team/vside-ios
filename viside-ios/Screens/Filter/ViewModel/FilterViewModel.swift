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
    
    private var stateObserver = BehaviorSubject<CardState>(value: .collapsed)
    init() {
        self.input = Input(stateObserver: stateObserver.asObserver())
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
    }
    struct Output {
        var showOpen: Driver<Bool>?
        var state: CardState = .collapsed
    }
    func changeState(_ state: CardState) {
        self.input.stateObserver.onNext(state)
    }
}

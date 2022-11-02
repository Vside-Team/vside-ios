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
        self.output.data = self.data
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
        var data: [Keyword] = []
        var numberOfData: Int {
            self.data.count
        }
    }
    func changeState(_ state: CardState) {
        self.input.stateObserver.onNext(state)
    }
}

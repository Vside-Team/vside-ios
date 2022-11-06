//
//  SearchViewModel.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import Foundation

final class SearchViewModel: ViewModelType {
    var input: Input
    var output: Output
    
    init() {
        self.input = Input()
        self.output = Output()
    }
}
extension SearchViewModel {
    struct Input {
        
    }
    struct Output {
        
    }
}

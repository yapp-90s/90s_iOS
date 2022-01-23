//
//  TemplateCellViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/12/26.
//

import Foundation

import RxSwift
import RxRelay

final class TemplateCellViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input: Input
    private(set) var output: Output
    
    let disposeBag = DisposeBag()
    
    init(dependency: Dependency) {
        self.dependency = dependency
        self.input = .init()
        self.output = .init(input: input, dependency: dependency)
    }
}

extension TemplateCellViewModel {
    
    struct Dependency {
        let isEditing: Bool
        let page: Page
        let template: Template
    }
    
    struct Input {
        
    }
    
    struct Output {
        let isEditing: Bool
        private let disposeBag = DisposeBag()
        
        init(input: Input, dependency: Dependency) {
            isEditing = dependency.isEditing
        }
    }
}

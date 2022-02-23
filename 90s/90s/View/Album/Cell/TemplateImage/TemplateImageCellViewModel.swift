//
//  TemplateImageCellViewModel.swift
//  90s
//
//  Created by 김진우 on 2022/02/05.
//

import Foundation

import RxSwift

final class TemplateImageCellViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input: Input
    private(set) var output: Output
    
    var disposeBag = DisposeBag()
    
    init(dependency: Dependency) {
        self.dependency = dependency
        self.input = .init()
        self.output = .init(input: input, dependency: dependency)
    }
}

extension TemplateImageCellViewModel {
    
    struct Dependency {
        let template: Template
        let photo: Photo
    }
    
    struct Input {
    }
    
    struct Output {
        init(input: Input, dependency: Dependency) {
            
        }
    }
}

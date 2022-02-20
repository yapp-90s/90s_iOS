//
//  TemplateThumbnailCellViewModel.swift
//  90s
//
//  Created by 김진우 on 2022/02/13.
//

import Foundation

import RxSwift
import RxRelay
import RxDataSources

final class TemplateThumbnailCellViewModel: ViewModelType {
    
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

extension TemplateThumbnailCellViewModel {
    struct Dependency {
        let template: Template
    }
    
    struct Input {
//        let select = PublishRelay<Void>()
    }
    
    struct Output {
        private let disposeBag = DisposeBag()
        
        let image: UIImage?
        let name: String?
        
        init(input: Input, dependency: Dependency) {
            image = .init(named: dependency.template.imageName)
            name = dependency.template.name
        }
    }
}

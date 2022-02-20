//
//  CoverImageCellViewModel.swift
//  90s
//
//  Created by 김진우 on 2022/02/13.
//

import Foundation

import RxSwift
import RxRelay
import RxDataSources

final class CoverImageCellViewModel: ViewModelType {
    
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

extension CoverImageCellViewModel {
    
    struct Dependency {
        let cover: Cover
    }
    
    struct Input {
    }
    
    struct Output {
        let image: UIImage?
        
        init(input: Input, dependency: Dependency) {
            image = dependency .cover.image
        }
    }
}

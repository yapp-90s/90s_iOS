//
//  AddAlbumViewModel.swift
//  90s
//
//  Created by woong on 2021/06/11.
//

import Foundation
import RxSwift
import RxRelay

class AddAlbumViewModel: ViewModelType {
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        self.output = Output(decoratedImage: BehaviorRelay<Data>.init(value: dependency.decoratedImage))
    }
}

extension AddAlbumViewModel {
    
    struct Dependency {
        var decoratedImage: Data
    }
    
    struct Input {

    }
    
    struct Output {
        var decoratedImage: BehaviorRelay<Data>
    }
}

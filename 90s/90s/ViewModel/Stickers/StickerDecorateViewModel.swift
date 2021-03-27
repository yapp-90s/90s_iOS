//
//  StickerDecorationViewModel.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import Foundation
import RxSwift

class PhotoDecorateViewModel: ViewModelType {
    var dependency: Dependency
    var input = Input()
    var output = Output()
    var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
    }
}

extension PhotoDecorateViewModel {
    struct Dependency {
        var selectedPhoto: Photo
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
}

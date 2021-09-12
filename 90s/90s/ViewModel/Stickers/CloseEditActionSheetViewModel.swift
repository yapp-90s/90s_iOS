//
//  CloseEditViewMidel.swift
//  90s
//
//  Created by kakao on 2021/09/11.
//

import RxSwift
import RxRelay

class CloseEditActionSheetViewModel: ViewModelType {
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    private(set) var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
    }
}

extension CloseEditActionSheetViewModel {
    struct Dependency {
        
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
}

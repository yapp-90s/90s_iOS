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
        
        self.input.tappedCancelButton
            .bind(to: self.output.cancel)
            .disposed(by: disposeBag)
        
        self.input.tappedCloseButton
            .bind(to: self.output.close)
            .disposed(by: disposeBag)
    }
}

extension CloseEditActionSheetViewModel {
    struct Dependency {
        
    }
    
    struct Input {
        var tappedCancelButton = PublishSubject<Void>()
        var tappedCloseButton = PublishSubject<Void>()
    }
    
    struct Output {
        var cancel = PublishSubject<Void>()
        var close = PublishSubject<Void>()
    }
}

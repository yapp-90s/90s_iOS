//
//  PhoneAuthenticationViewModel.swift
//  90s
//
//  Created by woongs on 2021/11/20.
//

import Foundation
import RxSwift

class PhoneAuthenticationViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    private(set) var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
    }
}

extension PhoneAuthenticationViewModel {
    
    struct Dependency { }
    
    struct Input { }
    
    struct Output { }
}

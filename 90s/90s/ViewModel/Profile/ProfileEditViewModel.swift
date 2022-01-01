//
//  ProfileEditViewModel.swift
//  90s
//
//  Created by woongs on 2022/01/01.
//

import Foundation
import RxSwift

final class ProfileEditViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input: Input
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    required init(dependency: Dependency = .init()) {
        self.dependency = dependency
        self.input = Input()
        self.output = Output()
    }
}

extension ProfileEditViewModel {
    
    struct Dependency { }
    
    struct Input { }
    
    struct Output { }
}

//
//  ProfileViewModel.swift
//  90s
//
//  Created by woongs on 2021/12/18.
//

import Foundation
import RxSwift

final class ProfileViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    private(set) var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
    }
}

extension ProfileViewModel {
    
    struct Dependency { }
    
    struct Input { }
    
    struct Output { }
}

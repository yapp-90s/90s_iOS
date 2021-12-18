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
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        
        self.output = Output(
            albumCount: self.dependency.albumCountObserver,
            photoCount: .just(0),
            filmCount: .just(0)
        )
    }
}

extension ProfileViewModel {
    
    struct Dependency {
        var albumCountObserver: Observable<Int>
    }
    
    struct Input { }
    
    struct Output {
        var albumCount: Observable<Int>
        var photoCount: Observable<Int>
        var filmCount: Observable<Int>
    }
}

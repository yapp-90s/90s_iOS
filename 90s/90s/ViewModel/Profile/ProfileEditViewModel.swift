//
//  ProfileEditViewModel.swift
//  90s
//
//  Created by woongs on 2022/01/01.
//

import Foundation
import RxSwift
import RxRelay

final class ProfileEditViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input: Input
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    private var nameStream = BehaviorRelay<String>(value: "")
    private var profileImageStream = BehaviorRelay<Data>(value: Data())
    private var editCompletePublisher = PublishSubject<Void>()
    
    required init(dependency: Dependency = .init()) {
        self.dependency = dependency
        self.input = Input()
        self.output = Output(
            nameObservable: self.nameStream.asObservable(),
            profileImageObservable: self.profileImageStream.asObservable(),
            editCompleteObservable: self.editCompletePublisher
        )
        
        self.input.editPublisher
            .bind(to: self.editCompletePublisher)
            .disposed(by: self.disposeBag)
    }
}

extension ProfileEditViewModel {
    
    struct Dependency { }
    
    struct Input {
        var nameStream = BehaviorRelay<String>(value: "")
        var editPublisher = PublishSubject<Void>()
    }
    
    struct Output {
        var nameObservable: Observable<String>
        var profileImageObservable: Observable<Data>
        var editCompleteObservable: Observable<Void>
    }
}

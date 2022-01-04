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
    
    private var profileService: ProfileService {
        return self.dependency.profileService
    }
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        self.input = Input(
            nameStream: self.nameStream
        )
        self.output = Output(
            nameObservable: self.nameStream.asObservable(),
            profileImageObservable: self.profileImageStream.asObservable(),
            editCompleteObservable: self.editCompletePublisher
        )
        
        self.input.editPublisher
            .subscribe(onNext: { [weak self] _ in
                self?.updateProfile()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func updateProfile() {
        let uploadbleProfile = UploadbleProfile(
            name: self.nameStream.value,
            image: UploadableImage(data: self.profileImageStream.value)
        )
        self.profileService.updateProfile(uploadbleProfile)
            .subscribe(onSuccess: { [weak self] response in
                self?.editCompletePublisher.onNext(())
            })
            .disposed(by: self.disposeBag)
    }
}

extension ProfileEditViewModel {
    
    struct Dependency {
        var profileService: ProfileService
    }
    
    struct Input {
        var nameStream: BehaviorRelay<String>
        var editPublisher = PublishSubject<Void>()
    }
    
    struct Output {
        var nameObservable: Observable<String>
        var profileImageObservable: Observable<Data>
        var editCompleteObservable: Observable<Void>
    }
}

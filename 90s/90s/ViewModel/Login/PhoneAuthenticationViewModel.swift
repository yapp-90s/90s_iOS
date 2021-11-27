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
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    private var isEnableRequestPhoneSns = BehaviorSubject<Bool>(value: false)
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        
        self.output = Output(
            isEnableRequestPhoneSms: self.isEnableRequestPhoneSns
        )
        
        self.input.phoneNumberChanged
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                let isValidPhoneNumber = self.validatePhoneNumber(with: text)
                self.isEnableRequestPhoneSns.onNext(isValidPhoneNumber)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func validatePhoneNumber(with numberText: String) -> Bool {
        let numbers = numberText.filter { $0.isNumber }
        return 10...11 ~= numbers.count
    }
}

extension PhoneAuthenticationViewModel {
    
    struct Dependency { }
    
    struct Input {
        var phoneNumberChanged = PublishSubject<String>()
    }
    
    struct Output {
        var isEnableRequestPhoneSms: Observable<Bool>
    }
}

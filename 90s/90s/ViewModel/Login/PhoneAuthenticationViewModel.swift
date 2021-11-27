//
//  PhoneAuthenticationViewModel.swift
//  90s
//
//  Created by woongs on 2021/11/20.
//

import Foundation
import RxSwift
import RxRelay

class PhoneAuthenticationViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    private var isEnableRequestPhoneSns = BehaviorSubject<Bool>(value: false)
    private var candidatePhoneNumber = BehaviorRelay<String>(value: "")
    private var certifiactionNumber = ""
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        
        self.output = Output(
            isEnableRequestPhoneSms: self.isEnableRequestPhoneSns
        )
        
        self.input.phoneNumberChanged
            .bind(to: self.candidatePhoneNumber)
            .disposed(by: self.disposeBag)
        
        self.candidatePhoneNumber
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                let isValidPhoneNumber = self.validatePhoneNumber(with: text)
                self.isEnableRequestPhoneSns.onNext(isValidPhoneNumber)
            })
            .disposed(by: self.disposeBag)
        
        self.input.requestPhoneSms
            .subscribe(onNext: { [weak self] _ in
                self?.requestPhoneSms()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func validatePhoneNumber(with numberText: String) -> Bool {
        let numbers = numberText.filter { $0.isNumber }
        return 10...11 ~= numbers.count
    }
    
    private func requestPhoneSms() {
        self.dependency.loginService.requestCheckPhoneNumber(self.candidatePhoneNumber.value)
            .subscribe { [weak self] certifiactionNumber in
                self?.certifiactionNumber = certifiactionNumber
            } onError: { error in
                // TODO:
                print(error)
            }
            .disposed(by: self.disposeBag)
    }
}

extension PhoneAuthenticationViewModel {
    
    struct Dependency {
        let loginService: LoginService
    }
    
    struct Input {
        var phoneNumberChanged = PublishSubject<String>()
        var requestPhoneSms = PublishSubject<Void>()
    }
    
    struct Output {
        var isEnableRequestPhoneSms: Observable<Bool>
    }
}

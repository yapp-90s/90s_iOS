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
    
    enum AuthenticationStep {
        case enterPhoneNumber
        case requestAuthenticationSms
        case responseAuthenticationSms
        case completeAuthentication
    }
    
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    private let validPhoneNumberLengthRange = 10...11
    private let validResponseNumberLength = 6
    
    private var candidatePhoneNumber = ""
    private var candidateAuthenticationResponseNumber = ""
    private var authenticationResponseNumber = ""
    
    private var authenticationStep = BehaviorRelay<AuthenticationStep>(value: .enterPhoneNumber)
    private var isHiddenAuthenticationTextField = BehaviorSubject<Bool>(value: true)
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        
        self.output = Output(
            authenticationStep: self.authenticationStep.asObservable(),
            isHiddenAuthenticationTextField: self.isHiddenAuthenticationTextField
        )
        
        self.input.phoneNumberChanged
            .subscribe(onNext: { [weak self] phoneNumber in
                guard let self = self else { return }
                self.candidatePhoneNumber = phoneNumber
                if self.validatePhoneNumber(with: phoneNumber) {
                    self.authenticationStep.accept(.requestAuthenticationSms)
                } else {
                    self.authenticationStep.accept(.enterPhoneNumber)
                }
            })
            .disposed(by: self.disposeBag)
        
        self.input.responseNumberChanged
            .subscribe(onNext: { [weak self] phoneNumber in
                guard let self = self else { return }
                guard self.authenticationStep.value == .responseAuthenticationSms ||
                        self.authenticationStep.value == .completeAuthentication
                else { return }
                
                self.candidateAuthenticationResponseNumber = phoneNumber
                if self.validateAuthenticationResponseNumber(with: phoneNumber) {
                    self.authenticationStep.accept(.completeAuthentication)
                } else {
                    self.authenticationStep.accept(.responseAuthenticationSms)
                }
            })
            .disposed(by: self.disposeBag)
        
        self.input.completeButtonDidTap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                switch self.authenticationStep.value {
                case .requestAuthenticationSms:
                    self.isHiddenAuthenticationTextField.onNext(false)
                    self.requestPhoneSms()
                    self.authenticationStep.accept(.responseAuthenticationSms)
                case .completeAuthentication:
                    if self.authenticationResponseNumber == self.candidateAuthenticationResponseNumber {
                        // TODO: 인증완료
                    }
                default: return
                }
            })
            .disposed(by: self.disposeBag)
        
        self.input.retryButtonDidTap
            .subscribe(onNext: { [weak self] in
                if self?.authenticationStep.value == .completeAuthentication {
                    self?.requestPhoneSms()
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func validatePhoneNumber(with numberText: String) -> Bool {
        let numbers = numberText.filter { $0.isNumber }
        return self.validPhoneNumberLengthRange ~= numbers.count
    }
    
    private func validateAuthenticationResponseNumber(with numberText: String) -> Bool {
        let numbers = numberText.filter { $0.isNumber }
        return self.validResponseNumberLength == numbers.count
    }
    
    private func requestPhoneSms() {
        self.dependency.loginService.requestCheckPhoneNumber(self.candidatePhoneNumber)
            .subscribe { [weak self] authenticationNumber in
                self?.authenticationResponseNumber = authenticationNumber
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
        var responseNumberChanged = PublishSubject<String>()
        var completeButtonDidTap = PublishSubject<Void>()
        var retryButtonDidTap = PublishSubject<Void>()
    }
    
    struct Output {
        var authenticationStep: Observable<AuthenticationStep>
        var isHiddenAuthenticationTextField: Observable<Bool>
    }
}

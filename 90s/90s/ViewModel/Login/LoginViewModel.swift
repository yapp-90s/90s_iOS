//
//  LoginViewModel.swift
//  90s
//
//  Created by woongs on 2021/10/09.
//

import Foundation
import RxSwift

final class LoginViewModel: ViewModelType, AppleLoginControllerDelegate {
    
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    private(set) var disposeBag = DisposeBag()
    
    private var loginService: LoginService {
        return self.dependency.loginService
    }
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        self.dependency.appleLoginController.delegate = self
        
        self.input.requestLoginStream
            .subscribe(onNext: { [weak self] loginType in
                self?.requestLogin(type: loginType)
            })
            .disposed(by: self.disposeBag)
    }
    
    public func setupAppleLoginPresentaion(_ presentation: AppleLoginPresentable) {
        self.dependency.appleLoginController.viewController = presentation
    }
    
    private func requestLogin(type loginType: LoginType) {
        switch loginType {
        case .kakao:
            self.loginService.requestKakaoLogin()
                .subscribe(onNext: { [weak self] loginOAuth in
                    guard let self = self else { return }
                    if let _ = loginOAuth {
                        // 로그인
                    } else {
                        // 회원가입
                        let phoneAuthViewModel = PhoneAuthenticationViewModel(dependency: .init(loginService: self.loginService))
                        self.output.signUpNeeded.onNext(phoneAuthViewModel)
                    }
                }, onError: { error in
                    // FIXME: 테스트용 임시 코드 -> 얼럿 띄워주는 형태로 수정
                    print("❌ API Error: \(error.localizedDescription)")
                    let phoneAuthViewModel = PhoneAuthenticationViewModel(dependency: .init(loginService: self.loginService))
                    self.output.signUpNeeded.onNext(phoneAuthViewModel)
                })
                .disposed(by: disposeBag)
        case .google:
            return
        case .apple:
            self.dependency.appleLoginController.handleAuthorizationAppleIDButtonPress()
        }
    }
    
    func appleLoginController(_ controller: AppleLoginController, didLoginSucceedWith userInfo: AppleLoginController.CredentialUserInfo) {
        if let email = userInfo.email {
            self.loginService.requestAppleLogin(email: email)
                .subscribe(onNext: { [weak self] loginOAuth in
                    guard let self = self else { return }
                    if let _ = loginOAuth {
                        // 로그인
                    } else {
                        let phoneAuthViewModel = PhoneAuthenticationViewModel(dependency: .init(loginService: self.loginService))
                        self.output.signUpNeeded.onNext(phoneAuthViewModel)
                    }
                })
                .disposed(by: self.disposeBag)
        } else {
            // TODO: handle Login Fail
        }
    }
    
    func appleLoginController(_ controller: AppleLoginController, didLoginFailWith error: Error) {
        // TODO: handle Login Fail
    }
}

extension LoginViewModel {
    
    struct Dependency {
        let loginService: LoginService = LoginService()
        let appleLoginController: AppleLoginController = AppleLoginController()
    }
    
    struct Input {
        var requestLoginStream = PublishSubject<LoginType>()
    }
    
    struct Output {
        var signUpNeeded = PublishSubject<PhoneAuthenticationViewModel>()
    }
}

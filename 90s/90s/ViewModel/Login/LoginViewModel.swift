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
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    private var loginService: LoginService {
        return self.dependency.loginService
    }
    
    private var loginSucceedPublisher = PublishSubject<Void>()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        self.output = Output(loginSucceed: self.loginSucceedPublisher)
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
            self.loginKakao()
        case .google:
            return
        case .apple:
            self.dependency.appleLoginController.handleAuthorizationAppleIDButtonPress()
        }
    }
    
    private func loginKakao() {
        self.loginService.requestKakaoLogin()
            .subscribe(onNext: { [weak self] loginOAuth in
                guard let self = self else { return }
                if let loginOAuth = loginOAuth {
                    self.login(with: loginOAuth.oAuthToken)
                } else {
                    self.needSignUp()
                }
            }, onError: { error in
                // FIXME: 테스트용 임시 코드 -> 얼럿 띄워주는 형태로 수정
                print("❌ API Error: \(error.localizedDescription)")
                self.needSignUp()
            })
            .disposed(by: disposeBag)
    }
    
    private func login(with token: String) {
        self.loginService.saveUserToken(token)
        self.loginSucceedPublisher.onNext(())
    }
    
    private func needSignUp() {
        let phoneAuthViewModel = PhoneAuthenticationViewModel(dependency: .init(loginService: self.loginService, loginSucceedPublisher: self.loginSucceedPublisher))
        self.output.signUpNeeded.onNext(phoneAuthViewModel)
    }
    
    func appleLoginController(_ controller: AppleLoginController, didLoginSucceedWith userInfo: AppleLoginController.CredentialUserInfo) {
        if let email = userInfo.email {
            self.loginService.requestAppleLogin(email: email)
                .subscribe(onNext: { [weak self] loginOAuth in
                    guard let self = self else { return }
                    if let loginOAuth = loginOAuth {
                        self.login(with: loginOAuth.oAuthToken)
                    } else {
                        self.needSignUp()
                    }
                })
                .disposed(by: self.disposeBag)
        } else {
            // TODO: handle Login Fail
        }
    }
    
    func appleLoginController(_ controller: AppleLoginController, didLoginFailWith error: Error) {
        // TODO: handle Apple Login Fail
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
        var loginSucceed: Observable<Void>
    }
}

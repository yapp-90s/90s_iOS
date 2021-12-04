//
//  LoginViewModel.swift
//  90s
//
//  Created by woongs on 2021/10/09.
//

import Foundation
import RxSwift

final class LoginViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        
        self.output = Output(
            phoneAuthenticationViewModel: PhoneAuthenticationViewModel(
                dependency: .init(loginService: dependency.loginService)
            )
        )
        
        self.input.requestLoginStream
            .subscribe(onNext: { [weak self] loginType in
                self?.requestLogin(type: loginType)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func requestLogin(type loginType: LoginType) {
        let service = self.dependency.loginService
        
        switch loginType {
        case .kakao:
            service.requestLogin(.kakao)
                .subscribe(onNext: { [weak self] loginOAuth in
                    guard let self = self else { return }
                    if let _ = loginOAuth {
                        // 로그인
                    } else {
                        // 회원가입
                        self.output.signUpNeeded.onNext(())
                    }
                }, onError: { error in
                    // FIXME: 테스트용 임시 코드 -> 얼럿 띄워주는 형태로 수정
                    print("❌ API Error: \(error.localizedDescription)")
                    self.output.signUpNeeded.onNext(())
                })
                .disposed(by: disposeBag)
        case .google:
            return
        case .apple:
            return
        }
    }
    
    private func requestKakaoEmail() {
        
    }
}

extension LoginViewModel {
    
    struct Dependency {
        let loginService: LoginService = LoginService()
    }
    
    struct Input {
        var requestLoginStream = PublishSubject<LoginType>()
    }
    
    struct Output {
        var phoneAuthenticationViewModel: PhoneAuthenticationViewModel
        var signUpNeeded = PublishSubject<Void>()
    }
}

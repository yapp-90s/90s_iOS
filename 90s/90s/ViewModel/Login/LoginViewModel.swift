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
    private(set) var output = Output()
    private(set) var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        
        self.input.requestLoginStream
            .subscribe(onNext: { [weak self] loginType in
                self?.requestLogin(type: loginType)
            })
            .disposed(by: self.disposeBag)
    }
    
    func requestLogin(type loginType: LoginType) {
        let service = self.dependency.loginService
        
        switch loginType {
        case .kakao:
            service.requestKakaoLogin()
                .subscribe(onNext: { oauth in
                    
                })
                .disposed(by: disposeBag)
        case .google:
            return
        case .apple:
            return
        }
    }
}

extension LoginViewModel {
    
    struct Dependency {
        let loginService: LoginService = LoginService()
    }
    
    struct Input {
        var requestLoginStream = PublishSubject<LoginType>()
    }
    
    struct Output { }
}

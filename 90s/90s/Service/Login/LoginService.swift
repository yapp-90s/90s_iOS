//
//  LoginService.swift
//  90s
//
//  Created by woongs on 2021/10/09.
//

import Foundation
import RxSwift
import Moya

class LoginService {
    
    typealias CertificationNumber = String
    
    private let userManager: UserManager
    private let kakaoSDKService: KakaoSDKService
    private let provider = MoyaProvider<LoginAPI>()
    private var loginType: LoginType?

    init(userManager: UserManager = .shared, kakaoSDKService: KakaoSDKService = KakaoSDKServiceImp()) {
        self.userManager = userManager
        self.kakaoSDKService = kakaoSDKService
    }
    
    // MARK: - Public
    
    public func requestKakaoLogin() -> Observable<LoginOAuthToken?> {
        self.loginType = .kakao
        return self.kakaoSDKService.requestKakaoLogin()
            .flatMap { [weak self] _ -> Single<String> in
                guard let self = self else { return .error(APIError.networkFail) }
                return self.kakaoSDKService.requestEmail()
            }
            .do { email in
                self.userManager.saveUserEmail(email)
            }
            .flatMap { [weak self] email -> Single<LoginOAuthToken?> in
                guard let self = self else { return .error(APIError.networkFail) }
                return self.requestLogin(type: .kakao, email: email, phoneNumber: "")
            }
            .catchError({ error -> Observable<LoginOAuthToken?> in
                return .error(error)
            })
            .asObservable()
    }
    
    public func requestAppleLogin(email: String) -> Observable<LoginOAuthToken?> {
        self.loginType = .apple
        self.userManager.saveUserEmail(email)
        return self.requestLogin(type: .apple, email: email, phoneNumber: "").asObservable()
    }
    
    public func requestSignUp(phoneNumber: String) -> Observable<LoginOAuthToken?> {
        guard let loginType = self.loginType,
              let email = userManager.userEmail
        else {
            return .error(APIError.NotSocialLogin)
        }
        
        return self.requestLogin(type: loginType, email: email, phoneNumber: phoneNumber).asObservable()
    }
    
    public func requestCheckPhoneNumber(_ phoneNumber: String) -> Single<CertificationNumber> {
        return self.provider.rx.request(.checkPhoneNumber(phoneNumber))
            .map(CertificationNumberResponse.self)
            .map { $0.num }
    }
    
    public func saveUserToken(_ token: String) {
        self.userManager.saveToken(token)
    }
    
    // MARK: - Private
    
    private func requestLogin(type: LoginType, email: String, phoneNumber: String = "") -> Single<LoginOAuthToken?> {
        return self.provider.rx.request(.login(type: .kakao, email: email, phoneNumber: phoneNumber))
            .flatMap({ response in
                if let loginResponse = try? response.map(LoginResponse.self) {
                    return .just(LoginOAuthToken(loginResponse.jwt, email))
                } else if let emailNotExistResponse = try? response.map(ErrorResponse.self), emailNotExistResponse.status == 400 {
                    return .just(nil)
                } else {
                    return .error(APIError.networkFail)
                }
            })
    }
}



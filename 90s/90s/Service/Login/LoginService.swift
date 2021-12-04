//
//  LoginService.swift
//  90s
//
//  Created by woongs on 2021/10/09.
//

import Foundation
import RxSwift
import KakaoSDKCommon
import KakaoSDKUser
import KakaoSDKAuth
import RxKakaoSDKUser
import RxKakaoSDKAuth
import Moya

class LoginService {
    
    typealias CertificationNumber = String
    
    let userManager: UserManager
    let provider = MoyaProvider<LoginAPI>()
    
    init(userManager: UserManager = .shared) {
        self.userManager = userManager
    }
    
    func requestLogin(_ type: LoginType) -> Observable<LoginOAuthToken?> {
        switch type {
        case .kakao:
            return self.requestKakaoLogin()
                .flatMap { [weak self] _ -> Single<String> in
                    guard let self = self else { return .error(APIError.networkFail) }
                    return self.requestEmail(type: .kakao)
                }
                .flatMap { [weak self] email -> Single<LoginOAuthToken?> in
                    guard let self = self else { return .error(APIError.networkFail) }
                    return self.requestLogin(type: .kakao, email: email)
                }
                .catchError({ error -> Observable<LoginOAuthToken?> in
                    return .error(error)
                })
                .asObservable()
        default:
            return .just(LoginOAuthToken("", ""))
        }
    }
    
    func requestLogin(type: LoginType, email: String) -> Single<LoginOAuthToken?> {
        return self.provider.rx.request(.login(type: .kakao, email: email, phoneNumber: ""))
            .flatMap({ response in
                if let loginResponse = try? response.map(LoginResponse.self) {
                    return .just(LoginOAuthToken(loginResponse.jwt, ""))
                } else if let emailNotExistResponse = try? response.map(ErrorResponse.self), emailNotExistResponse.status == 400 {
                    return .just(nil)
                } else {
                    return .error(APIError.networkFail)
                }
            })
    }
    
    func requestKakaoLogin() -> Observable<String> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return UserApi.shared.rx.loginWithKakaoTalk().map { $0.accessToken }
        } else {
            return UserApi.shared.rx.loginWithKakaoAccount().map { $0.accessToken }
        }
    }
    
    func requestEmail(type: LoginType) -> Single<String> {
        switch type {
        case .kakao:
            return UserApi.shared.rx.me()
                .map({ (user) -> KakaoSDKUser.User in
                    var scopes = [String]()
                    if (user.kakaoAccount?.emailNeedsAgreement == true) { scopes.append("account_email") }
                    if (scopes.count > 0) {
                        
                        throw SdkError(scopes:scopes)
                    } else {
                        return user
                    }
                })
                .retryWhen(Auth.shared.rx.incrementalAuthorizationRequired())
                .map { $0.kakaoAccount?.email ?? "" }
        default:
            return .just("")
        }
    }
    
    func requestCheckPhoneNumber(_ phoneNumber: String) -> Single<CertificationNumber> {
        return self.provider.rx.request(.checkPhoneNumber(phoneNumber))
            .map(CertificationNumberResponse.self)
            .map { $0.num }
    }
}



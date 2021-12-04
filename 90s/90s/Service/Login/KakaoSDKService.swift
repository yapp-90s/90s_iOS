//
//  KakaoService.swift
//  90s
//
//  Created by woongs on 2021/12/04.
//

import Foundation
import RxSwift
import KakaoSDKCommon
import KakaoSDKUser
import KakaoSDKAuth
import RxKakaoSDKUser
import RxKakaoSDKAuth

protocol KakaoSDKService {
    func requestKakaoLogin() -> Observable<String>
    func requestEmail() -> Single<String>
}

final class KakaoSDKServiceImp: KakaoSDKService {
    
    func requestKakaoLogin() -> Observable<String> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return UserApi.shared.rx.loginWithKakaoTalk().map { $0.accessToken }
        } else {
            return UserApi.shared.rx.loginWithKakaoAccount().map { $0.accessToken }
        }
    }
    
    func requestEmail() -> Single<String> {
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
    }
}

//
//  LoginService.swift
//  90s
//
//  Created by woongs on 2021/10/09.
//

import Foundation
import RxSwift
import KakaoSDKUser
import RxKakaoSDKUser

enum LoginType {
    case kakao
    case google
    case apple
}

class LoginService {
    
    func requestKakaoLogin() -> Observable<LoginOAuthToken> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return UserApi.shared.rx.loginWithKakaoTalk()
                .flatMap({ oauthToken -> Observable<LoginOAuthToken> in
                    print("kakao access token: \(oauthToken.accessToken)")
                    return Observable.just(LoginOAuthToken())
                })
        } else {
            return UserApi.shared.rx.loginWithKakaoAccount()
                .flatMap({ oauthToken -> Observable<LoginOAuthToken> in
                    print("kakao access token: \(oauthToken.accessToken)")
                    return Observable.just(LoginOAuthToken())
                })
        }
    }
}

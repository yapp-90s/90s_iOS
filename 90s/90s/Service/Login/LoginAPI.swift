//
//  LoginAPI.swift
//  90s
//
//  Created by woongs on 2021/11/13.
//

import Foundation
import Moya

struct LoginResponse: Decodable {
    var jwt: String
}

enum LoginType {
    case kakao
    case google
    case apple
}

enum LoginAPI {
    case login(type: LoginType, email: String, phoneNumber: String)
}

extension LoginAPI: BaseTarget {
    var path: String {
        switch self {
            case .login: return "user/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .login: return .post
        }
    }
    
    var task: Task {
        switch self {
            case let .login(type, email, phoneNumber):
                var parameters: [String: String] = [
                    "emailKakao" : "",
                    "emailApple" : "",
                    "emailGoogle" : "",
                    "phoneNum" : "\(phoneNumber)"
                ]
                
                switch type {
                case .kakao:
                    parameters["emailKakao"] = email
                case .google:
                    parameters["emailApple"] = email
                case .apple:
                    parameters["emailGoogle"] = email
                }
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
            case .login:
                return [
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                ]
        }
    }
}

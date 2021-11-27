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

struct CertificationNumberResponse: Decodable {
    var num: String
}

enum LoginType {
    case kakao
    case google
    case apple
}

enum LoginAPI {
    case login(type: LoginType, email: String, phoneNumber: String)
    case checkPhoneNumber(String)
}

extension LoginAPI: BaseTarget {
    var path: String {
        switch self {
            case .login: return "user/login"
            case .checkPhoneNumber: return "user/checkPhoneNum"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .login: return .post
            case .checkPhoneNumber: return .post
        }
    }
    
    var task: Task {
        switch self {
            case let .login(type, email, phoneNumber):
                var parameters: [String: String] = [
                    "emailKakao": "",
                    "emailApple": "",
                    "emailGoogle": "",
                    "phoneNum": "\(phoneNumber)"
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
        case let .checkPhoneNumber(phoneNumber):
            let parameters: [String: String] = [
                "phoneNumber": phoneNumber
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}

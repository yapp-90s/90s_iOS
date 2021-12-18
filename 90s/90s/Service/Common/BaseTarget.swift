//
//  BaseTarget.swift
//  90s
//
//  Created by woong on 2021/05/15.
//

import Moya

protocol BaseTarget: TargetType { }

extension BaseTarget {
    var baseURL: URL {
        return URL(string: "http://133.186.220.56/")!
    }
    
    // 테스트하는 동안 API의 가짜 객체를 제공
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-AUTH-TOKEN": UserManager.shared.token
        ]
    }
}

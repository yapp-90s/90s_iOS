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
        return URL(string: "http://49.50.162.246:8080/")!
    }
    
    // 테스트하는 동안 API의 가짜 객체를 제공
    var sampleData: Data {
        return Data()
    }
}

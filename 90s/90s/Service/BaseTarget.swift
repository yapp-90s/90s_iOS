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
        return URL(string: "https://90s.com/")!
    }
    
    var sampleData: Data {
        return Data()
    }
}

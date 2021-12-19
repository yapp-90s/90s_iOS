//
//  ProfileAPI.swift
//  90s
//
//  Created by woongs on 2021/12/18.
//

import Foundation
import Moya

enum ProfileAPI {
    case getReceivingEventIsOn
    case updateReceivingEventIsOn
}

extension ProfileAPI: BaseTarget {
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
    }
}

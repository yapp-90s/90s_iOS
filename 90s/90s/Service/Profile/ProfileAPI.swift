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
    case updateProfile(UploadbleProfile)
}

extension ProfileAPI: BaseTarget {
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .updateProfile(let profile):
            return .uploadMultipart(profile.multipartFormDatas)
        default: return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
        }
    }
}

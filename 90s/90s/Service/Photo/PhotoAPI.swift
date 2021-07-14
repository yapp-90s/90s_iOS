//
//  PhotoAPI.swift
//  90s
//
//  Created by 성다연 on 2021/07/14.
//

import Moya

enum PhotoAPI {
    typealias photoUid = (Int)
    typealias photoData = (image: UIImage, filmUid : Int)
    
    case download(_ data : photoUid)
    case upload(_ data : photoData)
}

extension PhotoAPI : BaseTarget {
    var path: String {
        switch self {
        case .download: return "photo/download"
        case .upload: return "photo/upload"
        }
    }
    
    var method: Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .download(let photo):
            return .requestParameters(parameters: ["photoUid" : photo], encoding: JSONEncoding.default)
        case .upload(let photo):
            return .requestParameters(parameters: [
                "image" : photo.image,
                "filmUid" : photo.filmUid
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .download:
            return [
                "Content-Type" : "application/json",
                "X-AUTH-TOKEN" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI3Iiwicm9sZXMiOlsiUk9MRV9UUllFUiJdLCJpYXQiOjE2MTI1NzA3MjQsImV4cCI6MjI0MzI5MDcyNH0.UCZtpbxD_3-mUAAtZwphgRSw-ZT7-DIbN2VZFzR0FQo",
                "Accept" : "application/octet-stream"
            ]
        case .upload:
            return [
                "Content-Type" : "application/json"
            ]
        }
    }
    
    
}

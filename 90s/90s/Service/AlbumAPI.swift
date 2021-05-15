//
//  AlbumAPI.swift
//  90s
//
//  Created by woong on 2021/05/15.
//

import Foundation
import Moya

enum AlbumAPI {
    typealias AlbumData = (name: String, layoutCode: Int, coverCode: Int, totPaper: Int)
    
    case create(_ data: AlbumData)
}

extension AlbumAPI: BaseTarget {
    var path: String {
        switch self {
            case .create: return "album/create"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
            case .create(let albumData):
                return .requestParameters(parameters: [
                    "name": albumData.name,
                    "layoutCode": albumData.layoutCode,
                    "coverCode": albumData.coverCode,
                    "totPaper": albumData.totPaper
                ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
            case .create:
                return [
                    "Content-Type": "application/json",
                    "X-AUTH-TOKEN": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI3Iiwicm9sZXMiOlsiUk9MRV9UUllFUiJdLCJpYXQiOjE2MTI1NzA3MjQsImV4cCI6MjI0MzI5MDcyNH0.UCZtpbxD_3-mUAAtZwphgRSw-ZT7-DIbN2VZFzR0FQo",
                    "Accept": "application/json"
                ]
        }
    }
}

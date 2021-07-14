//
//  FilmAPI.swift
//  90s
//
//  Created by 성다연 on 2021/07/14.
//

import Moya

enum FilmAPI {
    typealias FilmData = (filmCode : Int, name : String)
    case create(_ data : FilmData)
}


extension FilmAPI : BaseTarget {
    var path: String {
        switch self {
        case .create: return "film/create"
        }
    }
    
    var method: Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .create(let film):
            return .requestParameters(parameters: [
                "filmCode" : film.filmCode,
                "name" : film.name
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .create:
            return [
                "Content-Type" : "application/json",
                "X-AUTO-TOKEN" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI3Iiwicm9sZXMiOlsiUk9MRV9UUllFUiJdLCJpYXQiOjE2MTI1NzA3MjQsImV4cCI6MjI0MzI5MDcyNH0.UCZtpbxD_3-mUAAtZwphgRSw-ZT7-DIbN2VZFzR0FQo",
                "Accept": "application/json"
            ]
        }
    }
    
    
}

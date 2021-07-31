//
//  FilmAPI.swift
//  90s
//
//  Created by 성다연 on 2021/07/14.
//

import Moya

enum FilmAPI {
    typealias FilmData = (filmCode : Int, name : String)
    typealias JWT = (String)
    typealias FilmArray = [Film]
    
    case create(_ data : FilmData)
    case getFilms
    case startPrinting
}


extension FilmAPI : BaseTarget {
    var path: String {
        switch self {
        case .create: return "film/create"
        case .getFilms: return "film/getFilms"
        case .startPrinting: return "film/startPrinting"
        }
    }
    
    var method: Method {
        switch self {
        case .create:
            return .post
        case .getFilms, .startPrinting:
            return .get
        }
    }
    
    /**
     기본 요청 : plain request
     데이터 요청 : data request
     파라미터 요청 : parameter request
     업로드 요청 : upload request
    */
    var task: Task {
        switch self {
        case .create(let film):
            return .requestParameters(parameters: [
                "filmCode" : film.filmCode,
                "name" : film.name
            ], encoding: JSONEncoding.default)
        case .getFilms, .startPrinting:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .create:
            return [
                "Content-Type" : "application/json",
                "X-AUTO-TOKEN" : "\(JWT.self)",
                "Accept" : "application/json"
            ]
        case .getFilms, .startPrinting:
            return [
                "X-AUTO-TOKEN" : "\(JWT.self)",
                "Accept" : "application/json"
            ]
        }
    }
    
    // HTTP code 200 ~ 299 사이인 경우, 요청 성공
    var validationType: ValidationType {
        return .successCodes
    }
}

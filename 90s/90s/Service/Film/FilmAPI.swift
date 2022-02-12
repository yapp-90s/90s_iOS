//
//  FilmAPI.swift
//  90s
//
//  Created by 성다연 on 2021/07/14.
//

import Moya

enum FilmAPI {
    typealias JWT = (String)
    
    case create(filmCode: Int, filmName: String)
    case getFilms
    case startPrinting(filmUid: Int)
    case delete(filmUid: Int)
}


extension FilmAPI : BaseTarget {
    var testToken : String {
        return "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxNiIsInJvbGVzIjpbIlJPTEVfVFJZRVIiXSwiaWF0IjoxNjM5MjA5NTQ5LCJleHAiOjIyNjk5Mjk1NDl9.0og4uPl1vAID9UX3ASqVGGPrYgrIBoOxpDDAKuHCiKE"
    }
    
    var path: String {
        switch self {
        case .create: return "film/create"
        case .getFilms: return "film/getFilms"
        case .startPrinting(let filmUid): return "film/startPrinting/\(filmUid)"
        case .delete(let filmUid): return "film/delete/\(filmUid)"
        }
    }
    
    var method: Method {
        switch self {
        case .create:
            return .post
        case .getFilms, .startPrinting:
            return .get
        case .delete:
            return .delete
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
        case .create(let filmCode, let filmName):
            return .requestParameters(parameters: [
                "filmCode" : filmCode,
                "name" : filmName
            ], encoding: JSONEncoding.default)
        case .getFilms, .startPrinting, .delete:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .create, .delete:
            return [
                "Content-Type" : "application/json",
                "X-AUTH-TOKEN" : testToken,
                "Accept" : "application/json"
            ]
        case .getFilms, .startPrinting:
            return [
                "X-AUTH-TOKEN" : testToken,
                "Accept" : "application/json"
            ]
        }
    }
    
    // HTTP code 200 ~ 299 사이인 경우, 요청 성공
    var validationType: ValidationType {
        return .successCodes
    }
}

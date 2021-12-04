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
    
    case create(data: FilmData)
    case getFilms
    case startPrinting
    case filmDelete(filmUid : String, data: FilmData)
}


extension FilmAPI : BaseTarget {
    var path: String {
        switch self {
        case .create: return "film/create"
        case .getFilms: return "film/getFilms"
        case .startPrinting: return "film/startPrinting"
        case .filmDelete(let filmUid, _): return "film/delete/\(filmUid)"
        }
    }
    
    var method: Method {
        switch self {
        case .create, .filmDelete:
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
        case .create(let filmData):
            return .requestParameters(parameters: [
                "filmCode" : filmData.filmCode,
                "name" : filmData.name
            ], encoding: JSONEncoding.default)
        case .getFilms, .startPrinting:
            return .requestPlain
        case .filmDelete(_ ,let film):
            return .requestParameters(parameters: [
                "filmCode" : film.filmCode,
                "name" : film.name
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .create, .filmDelete:
            return [
                "Content-Type" : "application/json",
                "X-AUTH-TOKEN" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxNyIsInJvbGVzIjpbIlJPTEVfVEVTVEVSIl0sImlhdCI6MTYyNzk2NTE1NywiZXhwIjoyMjU4Njg1MTU3fQ._00DckJgm4nr22A8OE6AEdEx7JGozRkH4gqVrT4rJH0",
                "Accept" : "application/json"
            ]
        case .getFilms, .startPrinting:
            return [
                "X-AUTH-TOKEN" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxNyIsInJvbGVzIjpbIlJPTEVfVEVTVEVSIl0sImlhdCI6MTYyNzk2NTE1NywiZXhwIjoyMjU4Njg1MTU3fQ._00DckJgm4nr22A8OE6AEdEx7JGozRkH4gqVrT4rJH0",
                "Accept" : "application/json"
            ]
        }
    }
    
    // HTTP code 200 ~ 299 사이인 경우, 요청 성공
    var validationType: ValidationType {
        return .successCodes
    }
}

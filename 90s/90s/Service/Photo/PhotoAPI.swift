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
    typealias JWT = (String)
    
    case download(_ data : photoUid)
    case getPhotoInfosByFilm(_ filmUID : Int)
    case upload(_ data : photoData)
}

extension PhotoAPI : BaseTarget {
    var path : String {
        switch self {
        case .download: return "photo/download"
        case .upload: return "photo/upload"
        case .getPhotoInfosByFilm(let uid) : return "photo/getPhotoInfosByFilm/\(uid)"
        }
    }
    
    var method : Method {
        switch self {
        case .download, .upload:
            return .post
        case .getPhotoInfosByFilm:
            return .get
        }
    }
    
    var task : Task {
        switch self {
        case .download(let photoUID) :
            return .requestParameters(parameters: ["photoUid" : photoUID], encoding: JSONEncoding.default)
        case .upload(let photo) :
//            return .requestCompositeData(bodyData: <#T##Data#>, urlParameters: <#T##[String : Any]#>)
            return .requestParameters(parameters: [
                "image" : photo.image,
                "filmUid" : photo.filmUid
            ], encoding: JSONEncoding.default)
        case .getPhotoInfosByFilm:
            return .requestPlain
        }
    }
    
    var headers : [String : String]? {
        switch self {
        case .download :
            return [
                "Content-Type" : "application/json",
                "X-AUTH-TOKEN" : "\(JWT.self)",
                "Accept" : "application/octet-stream"
            ]
        case .upload :
            return [
                "Content-Type" : "application/json"
            ]
        case .getPhotoInfosByFilm :
            return [
                "X-AUTO-TOKEN" : "\(JWT.self)",
                "Accept" : "application/json"
            ]
        }
    }
}

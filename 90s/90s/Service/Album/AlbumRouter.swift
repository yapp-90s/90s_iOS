//
//  AlbumRouter.swift
//  90s
//
//  Created by 김진우 on 2021/11/27.
//

import Alamofire

enum AlbumRouter: URLRequestConvertible {
    case all
    case create(albumCreate: AlbumCreate)
    case addPhoto(photo: Photo)
    case complete(id: String)
    case delete(id: String)
    case plusReadCount(id: String)
    
    private var baseURL: String {
        #if DEBUG
        return "http://133.186.220.56"
        #else
        return "http://133.186.220.56"
        #endif
    }
    
    var method: HTTPMethod {
        switch self {
        case .all:
            return .get
        case .create:
            return .post
        case .addPhoto:
            return .post
        case .complete:
            return .get
        case .delete:
            return .delete
        case .plusReadCount:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .all:
            return "/album/getAlbums"
        case .create:
            return "/album/create"
        case .addPhoto:
            return "album/addPhotoInAlbum"
        case .complete(let id):
            return "/album/complete/\(id)"
        case .delete(let id):
            return "/album/delete/\(id)"
        case .plusReadCount(let id):
            return "/album/plusReadCnt/\(id)"
        }
    }
    
    var body: Data? {
        switch self {
        case .create(let albumCreate):
            let data = try? JSONEncoder().encode(albumCreate.attach)
            return data
        case .addPhoto(let photo):
            let data = try? JSONEncoder().encode(["photoUid": photo.photoUid, "albumUid": photo.photoUid, "paperNum": 1, "sequence": 2])
            return data
        default:
            return nil
        }
    }
    
    var queryString: [URLQueryItem] {
        switch self {
        default:
            return []
        }
    }
    
    var header: [String: String] {
        switch self {
        case .all, .create, .addPhoto, .complete, .delete, .plusReadCount:
            return [
                "Content-Type": "application/json",
                "X-AUTH-TOKEN": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0Iiwicm9sZXMiOlsiUk9MRV9URVNURVIiXSwiaWF0IjoxNjQ1MTEwNTkyLCJleHAiOjIyNzU4MzA1OTJ9.K8I2GCLrt30b41-7Pke9n0CLcDYATUbTpQgsc8W3-QM"
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        // Set URL (Base + Path)
        var urlComponent = URLComponents(string: baseURL + path)
        if !queryString.isEmpty {
            urlComponent?.queryItems = queryString
        }
        let url = urlComponent!.url!
        var request = URLRequest(url: url)
        
        // Set Method
        request.method = method
        
        // Set Header
        for (key, value) in header {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Set Body
        if let json = body {
            request.httpBody = json
        }
        return request
    }
}

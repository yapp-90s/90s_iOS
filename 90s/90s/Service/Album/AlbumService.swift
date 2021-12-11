//
//  AlbumService.swift
//  90s
//
//  Created by 김진우 on 2021/01/23.
//

import Moya
import RxSwift

final class AlbumService {
    
    let provider = MoyaProvider<AlbumAPI>()
    
    static let shared = AlbumService()
    
    var cover: Cover?
    var name: String?
    var template: Template?
    
    private init() {}
    
    func create(album data: AlbumAPI.AlbumData, completeHandler: @escaping (Result<Album, Error>) -> Void) {
        provider.request(.create(data)) { result in
            do {
                let response = try result.get()
                let value = try response.map(AlbumResponse.self)
                if let album = value.album {
                    completeHandler(.success(album))
                } else {
                    completeHandler(.failure(NSError(domain: "parsing", code: 0, userInfo: nil)))
                }
            } catch {
                completeHandler(.failure(error))
            }
        }
    }
}

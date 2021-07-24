//
//  FlimService.swift
//  90s
//
//  Created by 김진우 on 2021/01/23.
//

import Moya
import RxSwift

final class FlimService {
    
    static let shared = FlimService()
    
    let provider = MoyaProvider<FilmAPI>()
    
    var filmType : FilmType?
    var user : User?
    
    private init() {}
    
    func create(film data: FilmAPI.FilmData, completionHandler : @escaping (Result<Film, Error>) -> Void) {
        provider.request(.create(data)) { result in
            do {
                let response = try result.get()
                let value = try response.map(FilmResponse.self)
                completionHandler(.success(value.film))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}

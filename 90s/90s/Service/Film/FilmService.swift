//
//  FlimService.swift
//  90s
//
//  Created by 김진우 on 2021/01/23.
//

import Moya
import RxSwift

final class FilmService {
    
    static let shared = FilmService()
    
    let provider = MoyaProvider<FilmAPI>()
    
    var filmType : FilmFilterType?
    var user : User?
    
    private init() {}
    
    func create(film data: FilmAPI.FilmData, completionHandler : @escaping (Result<Film, Error>) -> Void) {
        provider.request(.create(data: data)) { result in
            do {
                let response = try result.get()
                let value = try response.map(FilmResponse.self)
                completionHandler(.success(value.film))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    func getFilm(completionHandler : @escaping (Result<[Film], Error>) -> Void) {
        provider.request(.getFilms) { result in
            do {
                let response = try result.get()
                let value = try response.map([FilmResponse].self)
                completionHandler(.success(value.map { $0.film }))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    func startPrinting(completionHandler : @escaping (Result<Film, Error>) -> Void) {
        provider.request(.startPrinting) { result in
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

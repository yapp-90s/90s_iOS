//
//  FlimService.swift
//  90s
//
//  Created by 김진우 on 2021/01/23.
//

extension URLRequest {
    public var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = "curl \(url.absoluteString)"
        
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        
        var command = [baseCommand]
        
        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }
        
        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }
        
        if let data = httpBody,
           let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }
        
        return command.joined(separator: " \\\n\t")
    }
    
    init?(curlString: String) {
        return nil
    }
}

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
        print(FilmAPI.getFilms)
        provider.request(.getFilms) { result in
            print("getfilm result =",result)
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
    
    func filmDelete(filmUid : String, film data: FilmAPI.FilmData, completionHandler : @escaping (Result<successResponse, Error>) -> Void) {
        provider.request(.filmDelete(filmUid: filmUid, data: data)) { result in
            do {
                let response = try result.get()
                let value = try response.map(successResponse.self)
                completionHandler(.success(value))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}

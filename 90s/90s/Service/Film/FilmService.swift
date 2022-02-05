//
//  FlimService.swift
//  90s
//
//  Created by 김진우 on 2021/01/23.
//

import Moya
import RxSwift

final class FilmService {
    private let networkLogger = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
    private var provider = MoyaProvider<FilmAPI>()
    
    init() {
        
    }
    
    func create(filmCode: Int, filmName: String) -> Single<FilmResponse> {
        provider = MoyaProvider<FilmAPI>(plugins: [networkLogger])

        return provider.rx.request(.create(filmCode: filmCode, filmName: filmName))
            .flatMap({ response in
                if let filmResponse = try? response.map(FilmResponse.self) {
                    return .just(filmResponse)
                } else {
                    return .error(APIError.networkFail)
                }
            })
    }
    
    func getFilmList() -> Single<[FilmResponse]> {
        //provider = MoyaProvider<FilmAPI>(plugins: [networkLogger])

        return provider.rx.request(.getFilms)
            .flatMap ({ response in
                if let filmListResponse = try? response.map([FilmResponse].self) {
                    return .just(filmListResponse)
                } else {
                    return .error(APIError.networkFail)
                }
            })
    }
    
    func startPrinting(filmUid: Int) -> Single<successResponse> {
        provider = MoyaProvider<FilmAPI>(plugins: [networkLogger])

        return provider.rx.request(.startPrinting(filmUid: filmUid))
            .flatMap ({ response in
                if let printResponse = try? response.map(successResponse.self) {
                    return .just(printResponse)
                } else {
                    return .error(APIError.networkFail)
                }
            })
    }
    
    func delete(filmUid: Int) -> Single<successResponse> {
        provider = MoyaProvider<FilmAPI>(plugins: [networkLogger])

        return provider.rx.request(.delete(filmUid: filmUid))
            .flatMap ({ response in
                if let deleteResponse = try? response.map(successResponse.self) {
                    return .just(deleteResponse)
                } else {
                    return .error(APIError.networkFail)
                }
            })
    }
}

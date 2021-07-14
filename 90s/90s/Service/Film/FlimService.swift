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
    
    private init() {}
}

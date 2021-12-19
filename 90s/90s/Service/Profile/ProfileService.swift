//
//  ProfileService.swift
//  90s
//
//  Created by woongs on 2021/12/18.
//

import Foundation
import RxSwift
import Moya

final class ProfileService {
    
    private let provider: MoyaProvider<ProfileAPI>
    
    init(provider: MoyaProvider<ProfileAPI> = .init()) {
        self.provider = provider
    }
    
    func updateReceivingEvent(isOn: Bool) -> Single<Response> {
        return self.provider.rx.request(.updateReceivingEventIsOn)
    }
}

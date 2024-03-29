//
//  ProfileSettingViewModel.swift
//  90s
//
//  Created by woongs on 2021/12/19.
//

import Foundation
import RxSwift
import RxRelay

final class ProfileSettingViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    private var isReceivingEventStream: BehaviorSubject<Bool>
    private var loggedOutPublisher = PublishSubject<Void>()
    
    private var pushManager: PushManager {
        return self.dependency.pushManager
    }
    
    private var userManager: UserManager {
        return self.dependency.userManager
    }
    
    private var profileService: ProfileService {
        return self.dependency.profileService
    }
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        self.isReceivingEventStream = BehaviorSubject<Bool>(value: self.dependency.pushManager.isReceivingEvent)
        self.output = Output(
            isReceivingEvent: self.isReceivingEventStream,
            loggedOut: self.loggedOutPublisher
        )
        
        self.input.toggleReceivingEvent
            .subscribe(onNext: { [weak self] isOn in
                if self?.pushManager.isReceivingEvent != isOn {
                    self?.updateReceivingEvent(isOn: isOn)
                }
            })
            .disposed(by: self.disposeBag)
        
        self.input.logout
            .subscribe(onNext: { [weak self] in
                self?.userManager.deleteToken()
                self?.loggedOutPublisher.onNext(())
            })
            .disposed(by: self.disposeBag)
    }
    
    func updateReceivingEvent(isOn: Bool) {
        self.profileService.updateReceivingEvent(isOn: isOn)
            .subscribe(onSuccess: { [weak self] response in
                self?.pushManager.updateReceivingEvent(isOn: isOn)
            }, onFailure: { error in
                // TODO: handle update receiving event fail
            })
            .disposed(by: self.disposeBag)
    }
}

extension ProfileSettingViewModel {
    
    struct Dependency {
        let pushManager: PushManager = .shared
        let userManager: UserManager = .shared
        let profileService: ProfileService
    }
    
    struct Input {
        var toggleReceivingEvent = PublishSubject<Bool>()
        var logout = PublishSubject<Void>()
    }
    
    struct Output {
        var isReceivingEvent: Observable<Bool>
        var loggedOut: Observable<Void>
    }
}

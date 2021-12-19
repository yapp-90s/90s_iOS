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
    
    private var pushManager: PushManager {
        return self.dependency.pushManager
    }
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        self.isReceivingEventStream = BehaviorSubject<Bool>(value: self.dependency.pushManager.isReceivingEvent)
        self.output = Output(isReceivingEvent: self.isReceivingEventStream)
        
        self.input.toggleReceivingEvent
            .subscribe(onNext: { [weak self] isOn in
                if self?.pushManager.isReceivingEvent != isOn {
                    self?.pushManager.updateReceivingEvent(isOn: isOn)
                }
            })
            .disposed(by: self.disposeBag)
    }
}

extension ProfileSettingViewModel {
    
    struct Dependency {
        let pushManager: PushManager
    }
    
    struct Input {
        var toggleReceivingEvent = PublishSubject<Bool>()
    }
    
    struct Output {
        var isReceivingEvent: Observable<Bool>
    }
}

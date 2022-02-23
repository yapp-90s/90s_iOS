//
//  PopupViewModel.swift
//  90s
//
//  Created by 김진우 on 2022/01/02.
//

import Foundation

import RxSwift
import RxRelay

final class PopupViewModel: ViewModelType {
    
    enum AlertType {
        case addPhoto
        case delete
        
        var title: String? {
            switch self {
            case .addPhoto:
                return "새로만든 앨범에\n사진을 바로 추가하시겠어요?"
            case .delete:
                return "앨범을 정말 삭제하시겠습니까?"
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .addPhoto:
                return .init(named: "Icon_Addphoto")
            case .delete:
                return .init(named: "icon_trash")
            }
        }
        
        var rejectTitle: String? {
            switch self {
            case .addPhoto:
                return "나중에"
            case .delete:
                return "취소"
            }
        }
        
        var conformTitle: String? {
            switch self {
            case .addPhoto:
                return "사진 추가하기"
            case .delete:
                return "삭제하기"
            }
        }
    }
    
    private(set) var dependency: Dependency
    private(set) var input: Input
    private(set) var output: Output
    
    var disposeBag = DisposeBag()
    
    init(dependency: Dependency) {
        self.dependency = dependency
        self.input = .init()
        self.output = .init(input: input, dependency: dependency)
    }
}

extension PopupViewModel {
    struct Dependency {
        let alertType: AlertType
    }
    
    struct Input {
        let reject = PublishRelay<Void>()
        let conform = PublishRelay<Void>()
    }
    
    struct Output {
        let iconImage: BehaviorSubject<UIImage?>
        let title: BehaviorSubject<String?>
        let rejectTitle: BehaviorSubject<String?>
        let conformTitle: BehaviorSubject<String?>
        let isDismiss: Observable<Bool>
        
        init(input: Input, dependency: Dependency) {
            isDismiss = .merge(input.conform.map { _ in true }.asObservable(), input.reject.map { _ in false }.asObservable())
            
            iconImage = .init(value: dependency.alertType.icon)
            title = .init(value: dependency.alertType.title)
            rejectTitle = .init(value: dependency.alertType.rejectTitle)
            conformTitle = .init(value: dependency.alertType.conformTitle)
        }
    }
    
    
}

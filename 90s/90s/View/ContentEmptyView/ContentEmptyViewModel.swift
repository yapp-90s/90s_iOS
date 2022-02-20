//
//  ContentEmptyViewModel.swift
//  90s
//
//  Created by 김진우 on 2022/01/02.
//

import Foundation

import RxSwift
import RxRelay

final class ContentEmptyViewModel: ViewModelType {
    
    enum EmptyType {
        case albumEmpty
        case filmEmpty
        
        var title: String {
            switch self {
            case .albumEmpty:
                return "마음에 드는 앨범을 골라\n사진을 추가해 보세요"
            case .filmEmpty:
                return "아직 필름이 없어요\n소중한 사진들로 필름을 만들어 보세요"
            }
        }
        
        var buttonTitle: String {
            switch self {
            case .albumEmpty:
                return "앨범 만들기"
            case .filmEmpty:
                return "필름 만들기"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .albumEmpty:
                return .init(named: "Img_EmptyStates_Album")
            case .filmEmpty:
                return .init(named: "Img_EmptyStates_Film")
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

extension ContentEmptyViewModel {
    struct Dependency {
        let emptyType: EmptyType
    }
    
    struct Input {
        let create = PublishRelay<Void>()
    }
    
    struct Output {
        let title: String
        let buttonTitle: String
        let image: UIImage?
        
        let create: Observable<Void>
        
        init(input: Input, dependency: Dependency) {
            title = dependency.emptyType.title
            buttonTitle = dependency.emptyType.buttonTitle
            image = dependency.emptyType.image
            
            create = input.create
                .asObservable()
        }
    }
}

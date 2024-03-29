//
//  AlbumCreateViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/04/10.
//

import RxSwift
import RxCocoa
import RxDataSources

struct AlbumCreateAttach: Codable {
    let name: String
    let layoutCode: Int
    let coverCode: Int
}

class AlbumCreate {
    var cover = BehaviorRelay<Cover>(value: .sweetLittleMemories)
    var name = BehaviorRelay<String>(value: "")
    var selectedIndex: Int = -1
    var template = BehaviorRelay<Template>(value: .init(name: "", imageName: "", code: 0, page: 0, imageMaxCount: 0, ratio: 1))
    var date = BehaviorRelay<Date>(value: .init())
    
    init() {
        cover.accept(.sweetLittleMemories)
    }
    
    var attach: AlbumCreateAttach {
        return .init(name: name.value, layoutCode: template.value.code, coverCode: cover.value.code)
    }
}

final class AlbumCreateViewModel {
    // MARK: - Input
    let selectCover: PublishRelay<Cover> = .init()
    let inputName: PublishRelay<String> = .init()
    let clearName: PublishRelay<Void> = .init()
    let selectTempalte: PublishRelay<TemplateViewModel> = .init()
    let next: PublishRelay<Void> = .init()
    let back: PublishRelay<Void> = .init()
    let close: PublishRelay<Void> = .init()
    let aaa: PublishSubject<Int> = .init()
    
    // MARK: - Output
//    typealias CoverSectionModel = SectionModel<String, CoverViewModel>
    typealias TemplateSectionModel = SectionModel<String, TemplateViewModel>
    let selectedCover: Driver<Cover>
//    let coverSection: BehaviorRelay<[CoverSectionModel]> = .init(value: [])
    let name: Driver<String>
    let selectedTemplate: PublishSubject<TemplateViewModel> = .init()
    let createDate: Driver<Date>
    let templateSection: BehaviorRelay<[TemplateSectionModel]> = .init(value: [])
    
    let selectedCoverRelay = BehaviorRelay<Cover>(value: .sweetLittleMemories)
    let selectedTemplateRelay = BehaviorRelay<TemplateViewModel>(value: TemplateViewModel(template: Template(name: "", imageName: "", code: 0, page: 0, imageMaxCount: 0, ratio: 1)))
    let nameRelay = BehaviorRelay<String>(value: "")
    let dateRelay = BehaviorRelay<Date>(value: Date())
    
    // MARK: - Property
    let disposeBag = DisposeBag()
    
    init() {
        selectedCover = selectedCoverRelay.asDriver()
        name = nameRelay.asDriver()
        selectedTemplateRelay
            .bind(to: selectedTemplate)
            .disposed(by: disposeBag)
        createDate = dateRelay.asDriver()
        
        bind()
    }
    
    private func bind() {
//        CoverService.shared
//            .viewModels()
//            .map({ [CoverSectionModel.init(model: "", items: $0)] })
//            .bind(to: coverSection)
//            .disposed(by: disposeBag)
        
//        TemplateService.shared.viewModels()
//            .map { [TemplateSectionModel.init(model: "", items: $0)] }
//            .bind(to: templateSection)
//            .disposed(by: disposeBag)
        
        next.subscribe(onNext:  {
            print("A")
        }).disposed(by: disposeBag)
        
        inputName
            .bind(to: nameRelay)
            .disposed(by: disposeBag)
        
        clearName.map({ "" })
            .bind(to: nameRelay)
            .disposed(by: disposeBag)
        
        selectCover
            .bind(to: selectedCoverRelay)
            .disposed(by: disposeBag)
        
        selectTempalte
            .bind(to: selectedTemplateRelay)
            .disposed(by: disposeBag)
    }
    
}

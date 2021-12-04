//
//  TemplateService.swift
//  90s
//
//  Created by 김진우 on 2021/04/18.
//

import RxSwift
import RxCocoa
import RxRelay

final class TemplateService {
    
    static let shared = TemplateService()
    
    private let templates = BehaviorRelay<[Template]>(value: [])
    
    private init() {
        templates.accept([
            Template(name: "PortraBlack", imageName: "Template_Preview_PortraBlack", code: 1001),
            Template(name: "PortraWhite", imageName: "Template_Preview_PortraWhite", code: 1002),
            Template(name: "MoodyPaper", imageName: "Template_Preview_MoodyPaper", code: 1003),
            Template(name: "Grass", imageName: "Template_Preview_Grass", code: 1004),
            Template(name: "Polaroid", imageName: "Template_Preview_Polaroid", code: 1005),
            Template(name: "Gradient", imageName: "Template_Preview_Gradient", code: 1006)
        ])
    }
    
    func all() -> [Template] {
        return templates.value
    }
    
    func pickTemplate(_ index: Int) -> Template {
        return templates.value[index]
    }
    
    func viewModels() -> Observable<[TemplateViewModel]> {
        let templates = self.templates.value
        let templateViewModels = templates.map { TemplateViewModel(template: $0) }
        return Observable.just(templateViewModels)
    }
}

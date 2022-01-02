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
            Template(name: "PortraBlack", imageName: "Template_Preview_PortraBlack", code: 1001, page: 8, imageMaxCount: 3),
            Template(name: "PortraWhite", imageName: "Template_Preview_PortraWhite", code: 1002, page: 8, imageMaxCount: 3),
            Template(name: "MoodyPaper", imageName: "Template_Preview_MoodyPaper", code: 1003, page: 12, imageMaxCount: 2),
            Template(name: "Grass", imageName: "Template_Preview_Grass", code: 1004, page: 12, imageMaxCount: 2),
            Template(name: "Polaroid", imageName: "Template_Preview_Polaroid", code: 1005, page: 12, imageMaxCount: 2),
            Template(name: "Gradient", imageName: "Template_Preview_Gradient", code: 1006, page: 12, imageMaxCount: 2)
        ])
    }
    
    func all() -> [Template] {
        return templates.value
    }
    
    func getTemplate(_ code: Int) -> Template? {
        return templates.value.filter({ $0.code == code }).first
    }
    
    func pickTemplate(_ index: Int) -> Template {
        return templates.value[index]
    }
    
    func getTemplateView(_ template: Template) -> TemplateView? {
        switch template.code {
        case 1001:
            return TemplatePortraBlack()
        case 1002:
            return TemplatePortraWhite()
        case 1003:
            return TemplateMoodyPaper()
        case 1004:
            return TemplateGrass()
        case 1005:
            return TemplatePolaroid()
        case 1006:
            return TemplateGradient()
        default:
            return nil
        }
    }
    
    func viewModels() -> Observable<[TemplateViewModel]> {
        let templates = self.templates.value
        let templateViewModels = templates.map { TemplateViewModel(template: $0) }
        return Observable.just(templateViewModels)
    }
}

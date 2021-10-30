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
                            Template(name: "PortraBlack", imageName: "Template_Preview_PortraBlack"),
                            Template(name: "PortraWhite", imageName: "Template_Preview_PortraWhite"),
                            Template(name: "MoodyPaper", imageName: "Template_Preview_MoodyPaper"),
                            Template(name: "Grass", imageName: "Template_Preview_Grass"),
                            Template(name: "Polaroid", imageName: "Template_Preview_Polaroid"),
                            Template(name: "Gradient", imageName: "Template_Preview_Gradient")
        ])
    }
    
    func viewModels() -> Observable<[TemplateViewModel]> {
        let templates = self.templates.value
        let templateViewModels = templates.map { TemplateViewModel(template: $0) }
        return Observable.just(templateViewModels)
    }
}

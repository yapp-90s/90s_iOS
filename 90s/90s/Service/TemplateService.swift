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
        templates.accept([Template(name: "Template1", imageName: "Template1"), Template(name: "Template2", imageName: "Template2"), Template(name: "Template3", imageName: ""), Template(name: "Tempalte4", imageName: ""), Template(name: "Template5", imageName: "")])
    }
    
    func viewModels() -> Observable<[TemplateViewModel]> {
        let templates = self.templates.value
        let templateViewModels = templates.map { TemplateViewModel(template: $0) }
        return Observable.just(templateViewModels)
    }
}

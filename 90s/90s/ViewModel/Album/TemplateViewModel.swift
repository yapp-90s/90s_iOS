//
//  TemplateViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/05/03.
//

import Foundation

import RxSwift

final class TemplateViewModel {
    var name: String
    var imageName: String
//    var name: Observable<String>
//    var imageName: Observable<String>
    
    init(template: Template) {
        name = template.name
        imageName = template.imageName
//        name = Observable.just(template.name)
//        imageName = Observable.just(template.imageName)
    }
}

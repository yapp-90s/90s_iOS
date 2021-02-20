//
//  ViewModelType.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import RxSwift

protocol ViewModelType {
    associatedtype Dependency
    associatedtype Input
    associatedtype Output

    var dependency: Dependency { get }
    var disposeBag: DisposeBag { get set }
    
    var input: Input { get }
    var output: Output { get }
    
    init(dependency: Dependency)
}

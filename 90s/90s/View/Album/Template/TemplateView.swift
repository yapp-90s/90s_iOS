//
//  TemplateView.swift
//  90s
//
//  Created by 김진우 on 2021/12/01.
//

import UIKit

protocol TemplateView where Self: UIView {
    var isEditing: Bool { get set }
    var delegate: TemplateViewDelegate? { get set }
    func bind(page: Page)
}

protocol TemplateViewDelegate: AnyObject {
    func didTapPhoto(index: Int)
}

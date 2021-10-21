//
//  TemplateImageView.swift
//  Template
//
//  Created by 김진우 on 2021/08/19.
//

import UIKit

import SnapKit

protocol TemplateImageViewDelegate: AnyObject {
    func tapped(_ index: Int)
}

protocol TemplateImageView where Self: UIView {
    var delegate: TemplateImageViewDelegate? { get }
    var imageView: UIImageView { get }
    var caseImageView: UIImageView { get }
}

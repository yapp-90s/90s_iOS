//
//  TemplateImageCell.swift
//  90s
//
//  Created by 김진우 on 2022/02/05.
//

import UIKit

import RxSwift

final class TemplateImageCell: UICollectionViewCell {
    
    static let identifier = "TemplateImageCell"
    
    let disposeBag = DisposeBag()
    private var viewModel: TemplateImageCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setLayout()
    }
    
    private func setLayout() {
        
    }
    
    func bind(viewModel: TemplateImageCellViewModel) {
        self.viewModel = viewModel
        
        if let templateImageView = TemplateService.shared.getTemplateImageView(template: viewModel.dependency.template, photo: viewModel.dependency.photo) {
            addSubview(templateImageView)
            templateImageView.snp.makeConstraints {
                $0.top.leading.bottom.trailing.equalToSuperview()
            }
        }
    }
}

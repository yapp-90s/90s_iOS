//
//  TemplateCell.swift
//  90s
//
//  Created by 김진우 on 2021/12/26.
//

import UIKit

import RxSwift
import RxCocoa

final class TemplateCell: UICollectionViewCell {
    
    static let identifier = "TemplateCell"
    
    let disposeBag = DisposeBag()
    
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
    
    func bind(viewModel: TemplateCellViewModel) {
        if let templateView = TemplateService.shared.getTemplateView(viewModel.dependency.template) {
            addSubview(templateView)
            templateView.snp.makeConstraints {
                $0.top.leading.bottom.trailing.equalToSuperview()
            }
        }
        
    }
}

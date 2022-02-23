//
//  TemplateCell.swift
//  90s
//
//  Created by 김진우 on 2021/12/26.
//

import UIKit

import RxSwift
import RxCocoa

protocol TemplateCellDelegate: AnyObject {
    func didTapPhoto(page: Int, index: Int)
}

final class TemplateCell: UICollectionViewCell {
    
    static let identifier = "TemplateCell"
    
    let disposeBag = DisposeBag()
    var templateView: TemplateView?
    private var viewModel: TemplateCellViewModel?
    weak var delegate: TemplateCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        templateView = nil
    }
    
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
        self.viewModel = viewModel
        if let cellTemplateView = TemplateService.shared.getTemplateView(viewModel.dependency.template) {
            cellTemplateView.delegate = self
            templateView = cellTemplateView
            templateView?.bind(page: viewModel.dependency.page)
            templateView?.isEditing = viewModel.dependency.isEditing
            addSubview(cellTemplateView)
            cellTemplateView.snp.makeConstraints {
                $0.top.leading.bottom.trailing.equalToSuperview()
            }
        }
        
    }
}

extension TemplateCell: TemplateViewDelegate {
    func didTapPhoto(index: Int) {
        if let viewModel = viewModel {
            delegate?.didTapPhoto(page: viewModel.dependency.page.number, index: index)
        }
    }
}

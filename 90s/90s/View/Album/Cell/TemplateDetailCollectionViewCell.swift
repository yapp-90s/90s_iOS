//
//  TemplateDetailCollectionViewCell.swift
//  90s
//
//  Created by 김진우 on 2021/05/05.
//

import UIKit
import RxSwift
import RxCocoa

final class TemplateDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TemplateDetailCollectionViewCell"
    
    let disposeBag = DisposeBag()
    
    lazy private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
    }
    
    private func setupUI() {
        imageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(1.662538)
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
    
    func bind(viewModel: TemplateViewModel) {
        imageView.backgroundColor = .white
//        viewModel.
    }
}

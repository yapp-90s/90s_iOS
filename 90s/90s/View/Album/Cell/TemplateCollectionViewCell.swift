//
//  TemplateCollectionViewCell.swift
//  90s
//
//  Created by 김진우 on 2021/05/04.
//

import UIKit
import RxSwift
import RxCocoa

class TemplateCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TemplateCollectionViewCell"
    
    let disposeBag = DisposeBag()
    
    lazy private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4 * layoutScale
        imageView.layer.masksToBounds = true
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy private(set) var label: UILabel = {
        let label = UILabel()
        label.font = .mediumText
        self.addSubview(label)
        return label
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
            $0.height.equalTo(imageView.snp.width).multipliedBy(1.664634)
            $0.left.right.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.height.equalTo(24 * layoutScale)
            $0.top.equalTo(imageView.snp.bottom).offset(6 * layoutScale)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func bind(viewModel: TemplateViewModel) {
        viewModel.imageName
            .map { UIImage(named: $0) }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.name
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}

//
//  CoverCollectionViewCell.swift
//  90s
//
//  Created by 김진우 on 2021/04/22.
//

import UIKit
import RxSwift
import RxCocoa

class CoverCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CoverCollectionViewCell"
    
    let disposeBag = DisposeBag()
    
    lazy private(set) var coverImageView: UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
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
        coverImageView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func bind(viewModel: CoverViewModel) {
        viewModel.cover
            .map { $0.image }
            .bind(to: coverImageView.rx.image)
            .disposed(by: disposeBag)
    }
}

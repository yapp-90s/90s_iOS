//
//  AlbumCoverCell.swift
//  90s
//
//  Created by 김진우 on 2021/11/20.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class AlbumCoverCell: UICollectionViewCell {
    
    static let identifier = "AlbumCoverCell"
    
    var viewModel: AlbumViewModel? {
        didSet {
            if let viewModel = viewModel {
                bindState(viewModel)
                bindAction(viewModel)
            }
        }
    }
    private let disposeBag = DisposeBag()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        addSubview(imageView)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Medium_Text_Bold
        label.textColor = .lightGray
        addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupUI()
    }
    
    private func setupUI() {
        imageView.snp.makeConstraints {
            $0.width.equalTo(imageView.snp.height)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20 * layoutScale)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func bindState(_ viewModel: AlbumViewModel) {
        viewModel.cover
            .map { $0?.image }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.name
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindAction(_ viewModel: AlbumViewModel) {
        
    }
}


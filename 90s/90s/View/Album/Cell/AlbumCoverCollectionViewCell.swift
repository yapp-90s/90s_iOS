//
//  AlbumCoverCollectionViewCell.swift
//  90s
//
//  Created by 김진우 on 2021/03/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AlbumCoverCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AlbumCoverCollectionViewCell"
    
    let disposeBag = DisposeBag()
    
    lazy private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .Medium_Text
        label.text = "자취일기\n"
        label.numberOfLines = 2
        self.addSubview(label)
        return label
    }()
    
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
            $0.left.top.right.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(6)
        }
    }
    
    func bind(viewModel: AlbumViewModel) {
        viewModel.name
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.cover.map { $0?.image }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}

//
//  AlbumPreviewCollectionViewCell.swift
//  90s
//
//  Created by 김진우 on 2021/03/27.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumPreviewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AlbumPreviewCollectionViewCell"
    
    let disposeBag = DisposeBag()
    
    lazy private(set) var coverImageView: UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        self.addSubview(label)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        self.addSubview(label)
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "albumMore"), for: .normal)
        self.addSubview(button)
        return button
    }()
    
    lazy var imageCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.backgroundColor = .blue
        self.addSubview(collectionView)
        return collectionView
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
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(8)
            $0.width.height.equalTo(52)
        }
        
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.left.equalTo(coverImageView.snp.right).offset(12)
            $0.top.equalToSuperview().offset(18)
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.left.equalTo(coverImageView.snp.right).offset(12)
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
        }
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(37)
            $0.top.equalToSuperview().offset(17)
            $0.right.equalToSuperview().offset(-18)
            $0.left.equalTo(dateLabel.snp.right).offset(12)
            $0.left.equalTo(nameLabel.snp.right).offset(12)
        }
        
//        imageCollectionView.snp.makeConstraints {
//            $0.top.equalTo(coverImageView.snp.bottom).offset(6)
//            $0.left.equalToSuperview().offset(18)
//            $0.right.equalToSuperview().offset(-18)
//            $0.bottom.equalToSuperview().offset(-10)
//        }
    }
    
    func bind(viewModel: AlbumViewModel) {
        viewModel.name
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.cover.map { $0?.image }
            .bind(to: coverImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.date
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

//
//  AlbumPreviewCell.swift
//  90s
//
//  Created by 김진우 on 2021/02/18.
//

import UIKit

class AlbumPreviewCell: UICollectionViewCell {
    
    static let identifier = "AlbumPreviewCell"
    
    lazy private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.backgroundColor = .red
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
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
            $0.left.top.bottom.equalToSuperview().offset(9)
            $0.width.equalTo(imageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(12)
            $0.right.bottom.equalToSuperview().offset(3)
            $0.height.equalTo(24)
        }
    }
    
    func refresh(with album: Album) {
        imageView.image = album.cover.image
        nameLabel.text = album.name
    }
}

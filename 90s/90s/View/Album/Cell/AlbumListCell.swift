//
//  AlbumListCell.swift
//  90s
//
//  Created by 김진우 on 2021/02/18.
//

import UIKit
import SnapKit

class AlbumListCell: UICollectionViewCell {
    
    static let identifier = "AlbumListCell"
    
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
        self.backgroundColor = .white
        
        imageView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(3)
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
    
    func refresh(with album: Album) {
        imageView.image = album.cover.image
        nameLabel.text = album.name
    }
}

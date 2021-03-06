//
//  StickerCollectionViewCell.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import UIKit

class StickerCollectionViewCell: UICollectionViewCell {
    static let identifier = "StickerCollectionViewCell"
    
    let stickerImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    func configure(sticker: Sticker) {
        stickerImageView.image = UIImage(named: sticker.imageName)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stickerImageView)
        
        stickerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

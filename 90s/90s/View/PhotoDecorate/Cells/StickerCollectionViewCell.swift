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
    
    // MARK: - Methods
    
    func configure(sticker: Sticker) {
        stickerImageView.image = UIImage(named: sticker.imageName)
    }
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    private func setupViews() {
        layer.cornerRadius = 11
        layer.masksToBounds = true
        
        addSubview(stickerImageView)
        
        stickerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

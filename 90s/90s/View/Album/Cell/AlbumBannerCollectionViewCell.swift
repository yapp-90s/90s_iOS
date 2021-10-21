//
//  AlbumBannerCollectionViewCell.swift
//  90s
//
//  Created by 김진우 on 2021/04/03.
//

import UIKit
import SnapKit

class AlbumBannerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AlbumBannerCollectionViewCell"
    
    lazy private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.backgroundColor = UIColor.colorRGBHex(hex: 0xBB8BCC)
        imageView.layer.cornerRadius = 6
        return imageView
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
            $0.top.equalToSuperview().offset(15 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
            $0.right.equalToSuperview().offset(-15 * layoutScale)
            $0.bottom.equalToSuperview().offset(-18 * layoutScale)
        }
    }
}

//
//  StickerPackCollectionViewCell.swift
//  90s
//
//  Created by woong on 2021/03/05.
//

import UIKit

class StickerPackCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "StickerPackCollectionViewCell"
    
    struct Constraints {
        static let nameToImageSpacing: CGFloat = -6
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "스티커팩이름"
        label.textColor = .lightGray
        
        return label
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.height.equalTo(92)
            $0.width.equalTo(imageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).inset(Constraints.nameToImageSpacing)
            $0.leading.trailing.equalToSuperview()
        }
        
    }
    
    func configure(pack: StickerPackType) {
        nameLabel.text = pack.name
        imageView.image = UIImage(named: pack.thumbnailImageName)
    }
}

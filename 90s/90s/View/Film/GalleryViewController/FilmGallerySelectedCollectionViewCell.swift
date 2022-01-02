//
//  FilmGallerySelectedCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/11/08.
//

import UIKit
import SnapKit

final class FilmGallerySelectedCollectionViewCell: UICollectionViewCell {
    private let imageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubViews() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func bindImageView(photo image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}

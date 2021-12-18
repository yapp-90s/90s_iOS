//
//  FilmGalleryCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/11/08.
//

import UIKit
import Photos
import SnapKit

final class FilmGalleryCollectionViewCell: UICollectionViewCell {
    private let imageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "default_img")
        
        return iv
    }()
    
    private let selectImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "film_edit_unselect")
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    // MARK: - Property
   
    private var thumbnailSize : CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: (UIScreen.main.bounds.width / 3) * scale, height: 100 * scale)
    }
    
    var film: Film!
    
    // MARK: - LifeCycle
    
    override func prepareForReuse() {
        self.selectImageView.image = UIImage(named: "film_edit_unselect")
        super.prepareForReuse()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setUpSubViews() {
        addSubview(imageView)
        addSubview(selectImageView)
        
        let safe = self.contentView.safeAreaLayoutGuide
        
        imageView.snp.makeConstraints {
            $0.edges.equalTo(safe)
        }
        
        selectImageView.snp.makeConstraints {
            $0.top.right.equalTo(safe)
            $0.width.height.equalTo(34)
        }
    }
    
    func bindImageView(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func bindSelectImageView(isSelected selected : Bool) {
        DispatchQueue.main.async {
            switch selected {
            case true:
                self.selectImageView.image = UIImage(named: "film_edit_select")
            case false:
                self.selectImageView.image = UIImage(named: "film_edit_unselect")
            }
        }
    }
}

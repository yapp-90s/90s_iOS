//
//  FilmGalleryCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/11/08.
//

import UIKit
import Photos

final class FilmGalleryCollectionViewCell: UICollectionViewCell {
    private let imageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.backgroundColor = .orange
        
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
    
    static let cellID = "FilmGalleryCollectionViewCell"
    
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
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        selectImageView.translatesAutoresizingMaskIntoConstraints = false
        selectImageView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        selectImageView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        selectImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        selectImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
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

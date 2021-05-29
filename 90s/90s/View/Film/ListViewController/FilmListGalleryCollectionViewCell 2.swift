//
//  FilmListGalleryCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/05/15.
//

import UIKit
import SnapKit

class FilmListGalleryCollectionViewCell: UICollectionViewCell {
    private let imageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        return iv
    }()
    
    private let accessoryImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "gallery_checkbox_edit_inact")
        return iv
    }()
    
    static let cellID = "FilmListGalleryCollectionViewCell"
    var thumbnailImage : UIImage! {
        didSet {
            imageView.image = thumbnailImage
        }
    }
    var representAssetIdentifier : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpSubViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        accessoryImageView.image = nil
    }
    
    private func setUpSubViews() {
        addSubview(imageView)
        addSubview(accessoryImageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
        
        accessoryImageView.snp.makeConstraints {
            $0.width.equalTo(34)
            $0.height.equalTo(34)
            $0.top.right.equalTo(0)
        }
    }
}

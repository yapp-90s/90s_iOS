//
//  FilmPhotoCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import UIKit
import SnapKit

/// 필름 뷰 하단 - 인하된 사진들을 보여주는 콜렉션 셀입니다
class FilmMainPhotoCollectionViewCell: UICollectionViewCell {
    private var photoImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    static let cellID = "photoCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews(){
        addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    func bindViewModel(image: String) {
        DispatchQueue.main.async { [weak self] in
            self?.photoImageView.image = UIImage(named: image)
        }
    }
}

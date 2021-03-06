//
//  FilmPhotoCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import UIKit
import SnapKit

/// 필름 뷰 하단 - 인하된 사진들을 보여주는 콜렉션 셀입니다
class FilmPhotoCollectionViewCell: UICollectionViewCell {
    static let photoCellID = "photoCell"
    
    var photoImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews(){
        self.addSubview(self.photoImageView)
        
        photoImageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
}

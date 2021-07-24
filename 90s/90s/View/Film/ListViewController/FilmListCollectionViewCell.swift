//
//  FilmListCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/02/20.
//

import UIKit
import SnapKit

/// 필름 속 사진들을 보여주는 콜렉션 셀
final class FilmListCollectionViewCell: UICollectionViewCell {
    private var imageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    static let cellId = "filmListCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubView(){
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    func bindViewModel(item: Photo, isScaleFill: Bool){
        if isScaleFill {
            imageView.contentMode = .scaleToFill
        }
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = UIImage(named: item.url)
        }
    }
}


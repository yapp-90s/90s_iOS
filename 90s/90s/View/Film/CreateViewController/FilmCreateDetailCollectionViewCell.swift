//
//  FilmCreateDetailCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/04/21.
//

import UIKit
import SnapKit

final class FilmCreateDetailCollectionViewCell: UICollectionViewCell {
    private let imageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubViews(){
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }
    
    func bindViewModel(image: String) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = UIImage(named: image)
        }
    }
}

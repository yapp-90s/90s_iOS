//
//  FilmCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import UIKit
import SnapKit

/// 필름 뷰 상단 - 헤더 셀에서 "내 필름 목록" 을 보여주는 콜렉션 셀입니다
final class FilmMainCollectionViewCell: UICollectionViewCell {
    private var filmImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private var filmImageLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Small_Text
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews(){
        addSubview(filmImageView)
        addSubview(filmImageLabel)
        
        filmImageView.snp.makeConstraints {
            $0.height.equalTo(133)
            $0.width.equalTo(88)
            $0.top.equalTo(0)
        }
        
        filmImageLabel.snp.makeConstraints {
            $0.left.right.equalTo(0)
            $0.top.equalTo(filmImageView.snp.bottom)
        }
    }
    
    func bindItem(film : Film){
        DispatchQueue.main.async { [weak self] in
            self?.filmImageView.image = UIImage(named: film.filmType.image)
        }
        filmImageLabel.text = film.name
    }
}

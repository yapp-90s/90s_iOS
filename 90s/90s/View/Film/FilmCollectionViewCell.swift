//
//  FilmCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import UIKit
import SnapKit

/// 필름 뷰 상단 - 헤더 셀에서 "내 필름 목록" 을 보여주는 콜렉션 셀입니다
class FilmCollectionViewCell: UICollectionViewCell {
    static let filmCellID = "filmCell"
    
    var filmImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.backgroundColor = .gray
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    var filmImageLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = label.font.withSize(13)
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
        self.addSubview(filmImageView)
        self.addSubview(filmImageLabel)
        
        filmImageView.contentMode = .scaleAspectFit
        filmImageView.clipsToBounds = true
        
        filmImageView.snp.makeConstraints {
            $0.height.equalTo(113)
            $0.top.left.right.equalTo(self)
        }
        
        filmImageLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(filmImageView.snp.bottom).offset(7)
        }
    }
    
    func bindItem(film : Film){
        filmImageView.image = UIImage(named: film.photos.first!.url)
        filmImageLabel.text = film.name
    }
}

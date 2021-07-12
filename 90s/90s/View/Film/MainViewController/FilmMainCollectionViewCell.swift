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
        return LabelType.normal_13.create()
    }()
    
    static let cellID = "filmCell"
    
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
            $0.height.equalTo(113)
            $0.top.left.right.equalTo(self)
        }
        
        filmImageLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(filmImageView.snp.bottom).offset(7)
        }
    }
    
    func bindItem(film : Film){
        DispatchQueue.main.async { [weak self] in
            self?.filmImageView.image = UIImage(named: film.filterType.image()) 
        }
        filmImageLabel.text = film.name
    }
}

//
//  FilmCreateDetailCollectionReusableView.swift
//  -> FilmCreateDetailCollectionViewHeaderCell (2021.12.18)
//  90s
//
//  Created by 성다연 on 2021/04/21.
//

import UIKit
import RxSwift

final class FilmCreateDetailCollectionViewHeaderCell: UICollectionViewCell {
    private let imageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    private var nameLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Title
        return label
    }()
    
    private var many_countTimeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Sub_Title
        return label
    }()
    
    private let createButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .retroOrange
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setTitle("이걸로 선택", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.tintColor = .white

        return button
    }()
    
    private var disposeBag = DisposeBag()
    
    var delegate : FilmCreateViewControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(many_countTimeLabel)
        addSubview(createButton)
        
        isUserInteractionEnabled = true
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(105)
            $0.height.equalTo(164)
            $0.top.equalTo(10)
            $0.left.equalTo(10)
        }
        
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(18)
            $0.top.equalTo(38)
        }
        
        many_countTimeLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(18)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        
        createButton.snp.makeConstraints {
            $0.width.equalTo(143)
            $0.height.equalTo(48)
            $0.top.equalTo(many_countTimeLabel.snp.bottom).offset(26)
            $0.left.equalTo(imageView.snp.right).offset(18)
        }
    }
    
    func bindViewModel(film: Film) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = UIImage(named: film.filmType.image)
        }
        
        nameLabel.text = film.name
        many_countTimeLabel.text = "\(film.filmType.max)장 · 인화 \(film.filmType.printDaysCount)시간 소요"
        
        createButton.rx.tap.bind {
            self.delegate?.presentFilmCreateVC(film: film)
        }.disposed(by: disposeBag)
    }
}

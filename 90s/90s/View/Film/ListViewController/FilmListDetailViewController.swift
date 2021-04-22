//
//  FilmListDetailViewController.swift
//  90s
//
//  Created by 성다연 on 2021/03/14.
//

import UIKit
import SnapKit

/// 필름 정보와 사진을 보여주는 VC
class FilmListDetailViewController: BaseViewController {
    private var filmImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "film_default")
        return iv
    }()
    
    private var filmNameLabel : UILabel = {
        let label = LabelType.bold_18.create()
        label.text = "필름이름"
        return label
    }()
    
    private var filmTypeLabel : UILabel = {
        let label = LabelType.normal_gray_13.create()
        label.text = "사진 추가 중"
        return label
    }()
    
    private var filmDateLabel : UILabel = {
        let label = LabelType.normal_gray_13.create()
        label.text = "2021.03.14"
        return label
    }()
    
    private var filmCountLabel : UILabel = {
        let label = LabelType.normal_21.create()
        label.text = "0/36장"
        return label
    }()
    
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private var printButton : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setTitle("인화하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .warmLightgray
        return btn
    }()
    
    private var emptyImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "film_photo_empty")
        return iv
    }()
    
    private var emptyAddMoreButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.setTitle("사진 추가하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .retroOrange
        return btn
    }()
    
    private var films : Film?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
    }

    private func setUpSubViews() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = false
       
        view.addSubview(collectionView)
        view.addSubview(filmImageView)
        view.addSubview(filmNameLabel)
        view.addSubview(filmTypeLabel)
        view.addSubview(filmDateLabel)
        view.addSubview(filmCountLabel)
        view.addSubview(printButton)
        
        view.addSubview(emptyImageView)
        view.addSubview(emptyAddMoreButton)
        
        let safe = view.safeAreaLayoutGuide
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FilmListCollectionViewCell.self, forCellWithReuseIdentifier: FilmListCollectionViewCell.cellId)
        
        filmImageView.snp.makeConstraints {
            $0.height.equalTo(134)
            $0.width.equalTo(100)
            $0.left.equalTo(safe).offset(18)
            $0.top.equalTo(safe).offset(20)
        }
        
        filmTypeLabel.snp.makeConstraints {
            $0.top.equalTo(safe).offset(20)
            $0.left.equalTo(filmImageView.snp.right).offset(18)
        }
        
        filmNameLabel.snp.makeConstraints {
            $0.top.equalTo(filmTypeLabel.snp.bottom).offset(14)
            $0.left.equalTo(filmImageView.snp.right).offset(18)
        }
        
        filmDateLabel.snp.makeConstraints {
            $0.top.equalTo(filmNameLabel.snp.bottom).offset(4)
            $0.left.equalTo(filmImageView.snp.right).offset(18)
        }
        
        filmCountLabel.snp.makeConstraints {
            $0.top.equalTo(filmDateLabel.snp.bottom).offset(28)
            $0.left.equalTo(filmImageView.snp.right).offset(18)
        }
        
        // hidden
        printButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(78)
            $0.right.equalTo(safe).offset(-18)
            $0.top.equalTo(filmDateLabel.snp.bottom).offset(24)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(filmCountLabel.snp.bottom).offset(55)
            $0.left.equalTo(safe).offset(18)
            $0.right.equalTo(safe).offset(-18)
            $0.bottom.equalTo(safe)
        }
        
        emptyImageView.snp.makeConstraints {
            $0.width.equalTo(163)
            $0.height.equalTo(142)
            $0.top.equalTo(filmCountLabel.snp.bottom).offset(58)
            $0.centerX.equalTo(safe)
        }
        
        emptyAddMoreButton.snp.makeConstraints {
            $0.width.equalTo(285)
            $0.height.equalTo(57)
            $0.top.equalTo(emptyImageView.snp.bottom).offset(50)
            $0.centerX.equalTo(safe)
        }
    }
    
    func bindViewModel(film : Film){
        DispatchQueue.main.async { [weak self] in
            self?.filmImageView.image = UIImage(named: film.filterType.image())
        }
        filmNameLabel.text = film.name
        filmDateLabel.text = film.createDate
        filmCountLabel.text = "\(film.count)/\(film.maxCount)장"
        filmTypeLabel.text = film.state.text()
        
        films = film
        
        if film.maxCount != film.photos.count && film.photos.count > 0 {
            let photo = Photo(id: "0000", url: "film_add_photo", date: "")
            films?.addAtFirst(photo)
        }
        
        if film.count == 0 {
            emptyImageView.isHidden = false
            emptyAddMoreButton.isHidden = false
            printButton.isHidden = true
        } else {
            emptyImageView.isHidden = true
            emptyAddMoreButton.isHidden = true
            printButton.isHidden = false
        }
        collectionView.reloadData()
    }
}


extension FilmListDetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 24, height: 166)
    }
}


extension FilmListDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let f = films {
            return f.photos.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmListCollectionViewCell.cellId, for: indexPath) as! FilmListCollectionViewCell
        if let f = films {
            cell.bindViewModel(item: f.photos[indexPath.row], isScaleFill: true)
        }
        return cell
    }
}

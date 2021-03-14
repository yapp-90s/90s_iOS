//
//  FilmListDetailViewController.swift
//  90s
//
//  Created by 성다연 on 2021/03/14.
//

import UIKit
import SnapKit

/// 필름 정보와 사진을 보여주는 VC
class FilmListDetailViewController: UIViewController {
    private var filmImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "filmimg")
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
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        return cv
    }()
    
    private var printBtn : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setTitle("인화하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = ColorType.Warm_Lightgray.create()
        return btn
    }()
    
    private var emptyImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "nofilmimg")
        return iv
    }()
    
    private var emptyAddMoreBtn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.setTitle("사진 추가하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = ColorType.Retro_Orange.create()
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
    }
}


extension FilmListDetailViewController {
    private func setUpSubViews(){
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(filmImageView)
        view.addSubview(filmNameLabel)
        view.addSubview(filmTypeLabel)
        view.addSubview(filmDateLabel)
        view.addSubview(filmCountLabel)
        view.addSubview(printBtn)
        
        view.addSubview(emptyImageView)
        view.addSubview(emptyAddMoreBtn)
        
        let safe = view.safeAreaLayoutGuide
        
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
        printBtn.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(78)
            $0.right.equalTo(safe).offset(-18)
            $0.top.equalTo(safe).offset(120)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(safe).offset(190)
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
        
        emptyAddMoreBtn.snp.makeConstraints {
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
        
        if film.count == 0 {
            emptyImageView.isHidden = false
            emptyAddMoreBtn.isHidden = false
            printBtn.isHidden = true
        } else {
            emptyImageView.isHidden = true
            emptyAddMoreBtn.isHidden = true
            printBtn.isHidden = false
        }
    }
}





//extension FilmListDetailViewController : UICollectionViewDelegate {
//
//}

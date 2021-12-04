//
//  AlbumSelectPhotoByFilmViewController.swift
//  90s
//
//  Created by 성다연 on 2021/12/04.
//

import UIKit
import SnapKit
import RxSwift

//TODO: 필름, 사진 비어있을 때 비어있다는 이미지 추가
final class AlbumSelectPhotoByFilmViewController: BaseViewController, UIScrollViewDelegate {
    
    private let filmImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "film_default")
        return iv
    }()
    
    private let filmNameLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Title
        label.text = "필름이름"
        return label
    }()
    
    private let filmDateLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Sub_Title
        label.textColor = .gray
        label.text = "2021.03.14"
        return label
    }()
    
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.register(FilmListCollectionViewCell.self, forCellWithReuseIdentifier: FilmListCollectionViewCell.cellId)
        return cv
    }()
    
    // MARK: - Property
    
    let viewModel : Film
    
    // MARK: - LifeCycle
    
    init(film: Film) {
        self.viewModel = film
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setupCollectionViewDataSource()
    }
    
    // MARK: - Methods
    
    private func setUpSubviews() {
        view.addSubview(filmImageView)
        view.addSubview(filmNameLabel)
        view.addSubview(filmDateLabel)
        view.addSubview(collectionView)
        
        let safe = view.safeAreaLayoutGuide
        
        filmImageView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(30)
            $0.left.equalTo(16)
            $0.top.equalTo(safe)
        }
        
        filmNameLabel.snp.makeConstraints {
            $0.top.equalTo(safe).offset(7)
            $0.left.equalTo(filmImageView.snp.right).offset(8)
        }
        
        filmDateLabel.snp.makeConstraints {
            $0.top.equalTo(filmNameLabel.snp.bottom).offset(2)
            $0.left.equalTo(filmImageView.snp.right).offset(8)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(filmDateLabel.snp.bottom).offset(20)
            $0.left.right.bottom.equalTo(safe)
        }
    }
    
    private func setupCollectionViewDataSource() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.from(optional: viewModel.photos)
            .bind(to: collectionView.rx.items(cellIdentifier: FilmListCollectionViewCell.cellId, cellType: FilmListCollectionViewCell.self)) { index, element, cell in
                cell.bindViewModel(item: element, isScaleFill: false)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Photo.self)
            .subscribe(onNext: { photo in
                let selectedPhoto = DecorateContainerViewModel(dependency: .init(selectedPhoto: photo))
                let nextVC = DecorateContainerViewController(selectedPhoto)
                self.navigationController?.pushViewController(nextVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel(film: Film) {
        DispatchQueue.main.async {
            self.filmImageView.image = UIImage(named: film.filmType.image)
        }
        
        filmNameLabel.text = film.name
        filmDateLabel.text = "\(film.count)장 · " + film.createdAt
        
        collectionView.reloadData()
    }
}

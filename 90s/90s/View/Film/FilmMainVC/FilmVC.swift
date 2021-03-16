//
//  FilmVC.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol FilmVCDelegate {
    func presentListVC()
}

class FilmVC : UIViewController {
    private var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: FilmPinterestLayout())
        cv.backgroundColor = .white
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private let viewModel = PhotoViewModel()
    private var disposeBag = DisposeBag()
    
    private var photoViewModel = PhotoViewModel().array

    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setUpCollectionView()
//        setupCollectionViewDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


extension FilmVC {
    private func setUpCollectionView(){
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layouts = collectionView.collectionViewLayout as? FilmPinterestLayout {
            layouts.delegate = self
        }
        
        collectionView.register(FilmHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmHeaderCollectionViewCell.headerCellID)
        collectionView.register(FilmPhotoCollectionViewCell.self, forCellWithReuseIdentifier: FilmPhotoCollectionViewCell.photoCellID)
        
        collectionView.snp.makeConstraints {
            $0.top.bottom.right.left.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupCollectionViewDataSource(){
        viewModel.photoObservable
            .bind(to: collectionView.rx.items(cellIdentifier: FilmPhotoCollectionViewCell.photoCellID, cellType: FilmPhotoCollectionViewCell.self)) { index, item, cell in
                cell.bindViewModel(image: item.image)
            }
            .disposed(by: disposeBag)
    }
}

extension FilmVC :  UICollectionViewDelegate, UICollectionViewDataSource{
    
    // MARK: Header cell setting
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmHeaderCollectionViewCell.headerCellID, for: indexPath) as? FilmHeaderCollectionViewCell else { return UICollectionReusableView() }
        header.delegate = self
        return header
    }
    
    // MARK: Collectionview setting
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmPhotoCollectionViewCell.photoCellID, for: indexPath) as? FilmPhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.bindViewModel(image: photoViewModel[indexPath.row].image)
        return cell
    }
}


extension FilmVC : FilmVCDelegate {
    func presentListVC() {
        navigationController?.pushViewController(FilmListVC(), animated: true)
    }
}


extension FilmVC : FilmPinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        if let image = UIImage(named: photoViewModel[indexPath.item].image) {
            return image.size.height
        }
        return 220
    }
}

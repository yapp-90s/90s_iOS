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
    func presentCreateVC()
}

class FilmMainViewController : BaseViewController {
    private var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: FilmPinterestLayout())
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private let viewModel = PhotoViewModel()
    private var photoViewModel = PhotoViewModel().array

    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
//        setupCollectionViewDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }

    private func setUpCollectionView(){
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layouts = collectionView.collectionViewLayout as? FilmPinterestLayout {
            layouts.delegate = self
        }
        
        collectionView.register(FilmMainHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmMainHeaderCollectionViewCell.cellID)
        collectionView.register(FilmMainPhotoCollectionViewCell.self, forCellWithReuseIdentifier: FilmMainPhotoCollectionViewCell.cellID)
        
        collectionView.snp.makeConstraints {
            $0.top.bottom.right.left.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupCollectionViewDataSource(){
        viewModel.photoObservable
            .bind(to: collectionView.rx.items(cellIdentifier: FilmMainPhotoCollectionViewCell.cellID, cellType: FilmMainPhotoCollectionViewCell.self)) { index, item, cell in
                cell.bindViewModel(image: item.image)
            }
            .disposed(by: disposeBag)
    }
}

extension FilmMainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Header cell setting
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmMainHeaderCollectionViewCell.cellID, for: indexPath) as? FilmMainHeaderCollectionViewCell else { return UICollectionReusableView() }
        header.delegate = self
        return header
    }
    
    // MARK: Collectionview setting
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmMainPhotoCollectionViewCell.cellID, for: indexPath) as? FilmMainPhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.bindViewModel(image: photoViewModel[indexPath.row].image)
        return cell
    }
}


extension FilmMainViewController : FilmVCDelegate {
    func presentListVC() {
        navigationController?.pushViewController(FilmListViewController(), animated: true)
    }
    func presentCreateVC() {
        navigationController?.pushViewController(FilmCreateViewController(), animated: true)
    }
}


extension FilmMainViewController : FilmPinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        if let image = UIImage(named: photoViewModel[indexPath.item].image) {
            return image.size.height
        }
        return 220
    }
}

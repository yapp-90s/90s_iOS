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
import RxDataSources

protocol FilmMainViewControllerDelegate {
    func presentListVC()
    func presentCreateVC()
}


class FilmMainViewController : BaseViewController, UIScrollViewDelegate {
    private var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: FilmPinterestLayout())
        
        cv.register(FilmMainHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmMainHeaderCollectionViewCell.cellID)
        cv.register(FilmMainPhotoCollectionViewCell.self, forCellWithReuseIdentifier: FilmMainPhotoCollectionViewCell.cellID)
        
        cv.showsVerticalScrollIndicator = false
        
        return cv
    }()
    
    // MARK: Property
    
    private let viewModel = PhotoViewModel(dependency: .init())
    
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
    
    // MARK: Method

    private func setUpCollectionView(){
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
    }
    
    private func setupCollectionViewDataSource(){
        let dataSource = RxCollectionViewSectionedReloadDataSource<FilmMainSectionModel>(configureCell: { (dataSource, collectionView, indexPath, element) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmMainPhotoCollectionViewCell.cellID, for: indexPath) as! FilmMainPhotoCollectionViewCell
            cell.bindViewModel(image: element.url)
            return cell
        })
        
        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmMainHeaderCollectionViewCell.cellID, for: indexPath) as! FilmMainHeaderCollectionViewCell
            header.delegate = self
            return header
        }
        
        dataSource.configureCell = { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmMainPhotoCollectionViewCell.cellID, for: indexPath) as! FilmMainPhotoCollectionViewCell
            cell.bindViewModel(image: item.url)
            return cell
        }
//
//        viewModel.photoObservable
//            .bind(to: collectionView.rx.items(dataSource: dataSource))
    
        
//        viewModel.photoObservable
//            .bind(to: collectionView.rx.items(cellIdentifier: FilmMainPhotoCollectionViewCell.cellID, cellType: FilmMainPhotoCollectionViewCell.self)) { index, item, cell in
//                cell.bindViewModel(image: item.image)
//            }
//            .disposed(by: disposeBag)
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
        return viewModel.output.photoViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmMainPhotoCollectionViewCell.cellID, for: indexPath) as? FilmMainPhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.bindViewModel(image: viewModel.output.photoViewModel.value[indexPath.row].url)
        return cell
    }
}


extension FilmMainViewController : FilmMainViewControllerDelegate {
    func presentListVC() {
        navigationController?.pushViewController(FilmListViewController(), animated: true)
    }
    func presentCreateVC() {
        navigationController?.pushViewController(FilmCreateViewController(), animated: true)
    }
}


extension FilmMainViewController : FilmPinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        
//        if let image = UIImage(named: viewModel.photoObservable.value[indexPath.item].url) {
//            print("FilmMainVC - collectionView image : lost image size")
//            return image.size.height
//        }
        return UIImage(named: viewModel.output.photoViewModel.value[indexPath.row].url)!.size.height
    }
}

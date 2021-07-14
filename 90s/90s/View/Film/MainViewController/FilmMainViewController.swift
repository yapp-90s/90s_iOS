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


final class FilmMainViewController : BaseViewController, UIScrollViewDelegate {
    private var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: FilmPinterestLayout())
        cv.showsVerticalScrollIndicator = false
        
        cv.register(FilmMainHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmMainHeaderCollectionViewCell.cellID)
        cv.register(FilmMainPhotoCollectionViewCell.self, forCellWithReuseIdentifier: FilmMainPhotoCollectionViewCell.cellID)
        return cv
    }()
    
    // MARK: Property
    
    private let viewModel = PhotoViewModel(dependency: .init())
    private var dataSource : RxCollectionViewSectionedReloadDataSource<FilmMainSectionModel>?
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setupCollectionViewDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Method

    private func setUpCollectionView(){
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
    }
    
    private func setupCollectionViewDataSource(){
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        dataSource = RxCollectionViewSectionedReloadDataSource<FilmMainSectionModel>(configureCell: { dataSource, collectionView, indexPath, element in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmMainPhotoCollectionViewCell.cellID, for: indexPath) as! FilmMainPhotoCollectionViewCell
            cell.bindViewModel(image: element.url)
            return cell
        })
        
        guard let datasource = dataSource else { return }
        
        datasource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmMainHeaderCollectionViewCell.cellID, for: indexPath) as! FilmMainHeaderCollectionViewCell
            header.delegate = self
            return header
        }

        viewModel.output.photoSectionViewModel
            .bind(to: collectionView.rx.items(dataSource: datasource)).disposed(by: disposeBag)
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
        cell.bindViewModel(image: (viewModel.output.photoSectionViewModel.value.first?.items[indexPath.row].url)!)
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
        return UIImage(named: viewModel.output.photoSectionViewModel.value.first!.items[indexPath.row].url)!.size.height
    }
}

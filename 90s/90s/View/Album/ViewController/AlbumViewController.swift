//
//  AlbumViewController.swift
//  90s
//
//  Created by 김진우 on 2021/02/07.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

let layoutScale = UIScreen.main.bounds.width / 375

class AlbumViewController: UIViewController {
    
    // MARK: - UI Component
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        var sections = self.sections
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        
        collectionView.register(AlbumTitleHeaderCollectionViewCell.self, forCellWithReuseIdentifier: AlbumTitleHeaderCollectionViewCell.identifier)
        collectionView.register(AlbumCreateCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCreateCollectionViewCell.identifier)
        collectionView.register(AlbumBannerCollectionViewCell.self, forCellWithReuseIdentifier: AlbumBannerCollectionViewCell.identifier)
        collectionView.register(AlbumCoverCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCoverCollectionViewCell.identifier)
        collectionView.register(AlbumPreviewCollectionViewCell.self, forCellWithReuseIdentifier: AlbumPreviewCollectionViewCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    // MARK: - Property
    private let viewModel: AlbumsViewModel
    private let disposeBag = DisposeBag()
    let sections: [AlbumSection] = [
        AlbumCreateSection(),
        AlbumBannerSection(),
        AlbumTitleHeaderSection(),
        AlbumCoverSection(),
        AlbumTitleHeaderSection(),
        AlbumPreviewSection()
    ]
    
    init(viewModel: AlbumsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        bindState()
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func setupUI() {
        navigationController?.title = "앨범 만들기(1/3)"
        
        collectionView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
    
    private func bindState() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<AlbumSectionModel>(configureCell: { (datasource, collectionView, indexPath, item) in
            return self.sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath, item: item)
        })
        
        viewModel.output.albumSection
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.createViewModel.openCreateAlbum
            .subscribe({ _ in
                self.createAlbum()
            })
            .disposed(by: disposeBag)
    }
    
    private func createAlbum() {
        let vc = AlbumCreateCoverViewController(viewModel: AlbumCreateViewModel())
        let naviVC = UINavigationController(rootViewController: vc)
        naviVC.modalPresentationStyle = .overFullScreen
        naviVC.navigationBar.isHidden = true
        DispatchQueue.main.async {
            self.present(naviVC, animated: false)
        }
    }
}

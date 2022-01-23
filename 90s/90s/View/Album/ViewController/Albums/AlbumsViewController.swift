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

class AlbumsViewController: BaseViewController {
    
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
    lazy var sections: [AlbumSection] = [
        AlbumCreateSection(),
        AlbumBannerSection(),
        AlbumTitleHeaderSection(delegate: nil),
        AlbumCoverSection(),
        AlbumTitleHeaderSection(delegate: self),
        AlbumPreviewSection()
    ]
    
    // MARK: - Init
    init(viewModel: AlbumsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        bindState()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20 * layoutScale)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
//        let view3 = ContentEmptyView(viewModel: .init(dependency: .init(emptyType: .albumEmpty)))
//        view.addSubview(view3)
//        view3.snp.makeConstraints {
//            $0.top.leading.trailing.bottom.equalToSuperview()
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let vc = PopupViewController(viewModel: .init(dependency: .init(alertType: .delete)))
//        vc.modalPresentationStyle = .overFullScreen
//        DispatchQueue.main.async {
//            self.present(vc, animated: false, completion: nil)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func bindState() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<AlbumSectionModel>(configureCell: { (datasource, collectionView, indexPath, item) in
            return self.sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath, item: item)
        })
        
        viewModel.output.albumSection
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.createViewModel
            .bind { self.createAlbum($0) }
            .disposed(by: disposeBag)
        
        viewModel.output.selectedMakingAlbum
            .bind { self.showMakingAlbum($0) }
            .disposed(by: disposeBag)
        
        viewModel.output.selectedAlbum
            .bind { self.showAlbum($0) }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        collectionView.rx.itemSelected
            .filter { $0.section == 0 }
            .map { _ in () }
            .bind(to: viewModel.input.createAlbumButton)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .filter { $0.section == 3 }
            .bind(to: viewModel.input.selectMakingAlbum)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .filter { $0.section == 5 }
            .bind(to: viewModel.input.selectAlbum)
            .disposed(by: disposeBag)
        
        viewModel.input.refresh.accept(())
    }
    
    
    // MARK: - Method
    private func createAlbum(_ viewModel: AlbumCoverViewModel) {
        let vc = AlbumCoverViewController(viewModel: viewModel)
        let naviVC = UINavigationController(rootViewController: vc)
        naviVC.modalPresentationStyle = .overFullScreen
        naviVC.navigationBar.isHidden = true
        
        DispatchQueue.main.async {
            self.present(naviVC, animated: false)
        }
    }
    
    private func showMakingAlbum(_ albumViewModel: AlbumViewModel) {
        let vc = AlbumDetailViewController(viewModel: .init(dependency: .init(isEditing: true, albumViewModel: albumViewModel)))
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
    
    private func showAlbum(_ albumViewModel: AlbumViewModel) {
        let vc = AlbumDetailViewController(viewModel: .init(dependency: .init(isEditing: false, albumViewModel: albumViewModel)))
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
}

extension AlbumsViewController: AlbumTitleHeaderCellDelegate {
    func touchButton() {
        let vc = AlbumListViewController(viewModel: .init(dependency: .init(albumRepository: .shared)))
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//
//  AlbumViewController.swift
//  90s
//
//  Created by 김진우 on 2021/12/01.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources


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
    lazy var sections: [AlbumSection] = [
        AlbumCreateSection(),
        AlbumBannerSection(),
        AlbumTitleHeaderSection(delegate: nil),
        AlbumCoverSection(),
        AlbumTitleHeaderSection(delegate: self),
        AlbumPreviewSection()
    ]
    
    init(viewModel: AlbumsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        bindState()
        bindAction()
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let vc = UIViewController()
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
    
    private func showAlbum(_ albumViewModel: AlbumViewModel) {
//        switch albumViewModel.template {
//        case ....:
//            return TemplateView()
//        }
        
        let vc = UIViewController()
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
    
//    private func templateToTemplateView() -> TemplateView {
//        
//    }
}

extension AlbumViewController: AlbumTitleHeaderCellDelegate {
    func touchButton() {
        let vc = AlbumListViewController(viewModel: .init(dependency: .init(albumRepository: .shared)))
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

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
    func presentDetailVC(viewModel: Film)
}

final class FilmMainViewController : BaseViewController, UIScrollViewDelegate {
    private let collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.showsVerticalScrollIndicator = false
        
        cv.registerHeader(reusable: FilmMainHeaderCollectionViewCell.self)
        cv.register(reusable: PinterestCollectionViewCell.self)
        
        return cv
    }()
    
    // MARK: Property
    
    private var viewModel : FilmsViewModel
    
    // MARK: Life Cycles
    
    init(viewModel : FilmsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setUpSubviews()
        setupCollectionViewDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Method

    private func setUpSubviews(){
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupCollectionViewDataSource(){
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<FilmMainSectionModel>(configureCell: { dataSource, collectionView, indexPath, element in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinterestCollectionViewCell.cellID, for: indexPath) as! PinterestCollectionViewCell
            cell.bindViewModel(image: element.url)
            return cell
        })
        
        dataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmMainHeaderCollectionViewCell.reuseIdentifier, for: indexPath) as! FilmMainHeaderCollectionViewCell
            header.delegate = self
            
            return header
        }
         
        viewModel.output.films
            .map { [FilmMainSectionModel(header: "", items: $0.map { $0.photos }.reduce([], +))] }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        let layout = PinterestLayout()
        layout.delegate = self
        collectionView.collectionViewLayout = layout
    }
}


extension FilmMainViewController : FilmMainViewControllerDelegate {
    func presentListVC() {
        navigationController?.pushViewController(FilmListViewController(viewModel: viewModel), animated: true)
    }
    
    func presentCreateVC() {
        navigationController?.pushViewController(FilmCreateViewController(), animated: true)
    }
    
    func presentDetailVC(viewModel: Film) {
        navigationController?.pushViewController(FilmListDetailViewController(viewModel: viewModel), animated: true)
    }
}


extension FilmMainViewController : PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        var height = 0.0
        
        viewModel.output.photos
            .subscribe(onNext: { value in
                height = value[indexPath.row].height
            }).disposed(by: disposeBag)
        
        return height
    }
}

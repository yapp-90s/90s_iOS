//
//  FilmCreateDetailViewController.swift
//  90s
//
//  Created by 성다연 on 2021/04/21.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

final class FilmCreateDetailViewController: BaseViewController {
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FilmCreateDetailCollectionViewCell.self, forCellWithReuseIdentifier: FilmCreateDetailCollectionViewCell.cellID)
        cv.register(FilmCreateDetailCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmCreateDetailCollectionReusableView.cellID)
        return cv
    }()
    
    let viewModel : Film
    var delegate : FilmCreateViewControllerDelegate?
    
    init(viewModel: Film) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpCollectionView()
    }
    
    private func setUpSubViews(){
        view.backgroundColor = .black
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setUpCollectionView() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<FilmMainSectionModel>(configureCell: { dataSource, collectionView, indexPath, element in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCreateDetailCollectionViewCell.cellID, for: indexPath) as! FilmCreateDetailCollectionViewCell
            cell.bindViewModel(image: element.url)
            return cell
        })
        
        dataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmCreateDetailCollectionReusableView.cellID, for: indexPath) as! FilmCreateDetailCollectionReusableView
            header.delegate = self.delegate
            header.bindViewModel(film: self.viewModel)
            return header
        }
        
        Observable.from(optional: viewModel.photos)
            .map { [FilmMainSectionModel(header: "", items: $0)]}
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}


extension FilmCreateDetailViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 36, height: 340)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 175)
    }
}

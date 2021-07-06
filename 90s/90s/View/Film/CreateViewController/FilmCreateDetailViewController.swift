//
//  FilmCreateDetailViewController.swift
//  90s
//
//  Created by 성다연 on 2021/04/21.
//

import UIKit
import SnapKit

class FilmCreateDetailViewController: BaseViewController {
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FilmCreateDetailCollectionViewCell.self, forCellWithReuseIdentifier: FilmCreateDetailCollectionViewCell.cellID)
        cv.register(FilmCreateDetailCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmCreateDetailCollectionReusableView.cellID)
        return cv
    }()
    
    var film: Film!
    var delegate : FilmCreateViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
    }
    
    private func setUpSubViews(){
        view.backgroundColor = .black
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


extension FilmCreateDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return film.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCreateDetailCollectionViewCell.cellID, for: indexPath) as! FilmCreateDetailCollectionViewCell
        cell.bindViewModel(image: film.photos[indexPath.row].url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 36, height: 340)
    }
    
    // MARK: Collection Header Setting
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FilmCreateDetailCollectionReusableView.cellID, for: indexPath) as! FilmCreateDetailCollectionReusableView
        header.bindViewModel(film: film)
        header.delegate = delegate
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 175)
    }
}

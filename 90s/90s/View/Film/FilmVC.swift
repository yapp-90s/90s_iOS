//
//  FilmVC.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import UIKit
import SnapKit

class FilmVC : UIViewController {
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: FilmPinterestLayout())
    private var photoViewModel = PhotoViewModel().array

    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
}


extension FilmVC {
    private func setUpCollectionView(){
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        
        if let layouts = collectionView.collectionViewLayout as? FilmPinterestLayout {
            layouts.delegate = self
        }
        
        collectionView.register(FilmHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmHeaderCollectionViewCell.headerCellID)
        collectionView.register(FilmPhotoCollectionViewCell.self, forCellWithReuseIdentifier: FilmPhotoCollectionViewCell.photoCellID)
        
        collectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// 데이터를 어떻게 넣어주어야할지 모르겠다 !

extension FilmVC : UICollectionViewDataSource,  UICollectionViewDelegate {
    
    // MARK: Header cell setting
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilmHeaderCollectionViewCell.headerCellID, for: indexPath) as? FilmHeaderCollectionViewCell else { return UICollectionReusableView() }
        
        return header
    }
    
    // MARK: Collectionview setting
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmPhotoCollectionViewCell.photoCellID, for: indexPath) as? FilmPhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.photoImageView.image = UIImage(named: photoViewModel[indexPath.row].image)
            
        return cell
    }
}


extension FilmVC : FilmPinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return (UIImage(named: photoViewModel[indexPath.item].image)?.size.height) ?? 220
    }
}

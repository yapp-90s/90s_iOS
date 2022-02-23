//
//  AlbumTitleHeaderSection.swift
//  90s
//
//  Created by 김진우 on 2021/04/04.
//

import UIKit

import RxSwift

struct AlbumTitleHeaderSection: AlbumSection {
    let numberOfItems = 1
    var delegate: AlbumTitleHeaderCellDelegate?
    let disposeBag = DisposeBag()
    
    init(delegate: AlbumTitleHeaderCellDelegate?) {
        self.delegate = delegate
    }
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48 * layoutScale))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AlbumSectionItem) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumTitleHeaderCollectionViewCell.identifier, for: indexPath) as! AlbumTitleHeaderCollectionViewCell
        if indexPath.section == 3 {
            cell.isComplete = true
            cell.isButtton = true
            cell.delegate = delegate
            cell.label.text = "내 앨범"
            AlbumRepository.shared.completeAlbums
                .bind { albums in
                    cell.buttonTitle = "총 \(albums.count)개"
                }
                .disposed(by: disposeBag)
        } else {
            cell.isButtton = true
            cell.delegate = delegate
            cell.label.text = "만드는 중!"
            AlbumRepository.shared.makeingAlbums
                .bind { albums in
                    cell.buttonTitle = "총 \(albums.count)개"
                }
                .disposed(by: disposeBag)
        }
        
        return cell
    }
}

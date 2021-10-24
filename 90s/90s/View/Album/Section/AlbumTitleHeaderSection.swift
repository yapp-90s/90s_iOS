//
//  AlbumTitleHeaderSection.swift
//  90s
//
//  Created by 김진우 on 2021/04/04.
//

import UIKit

struct AlbumTitleHeaderSection: AlbumSection {
    let numberOfItems = 1
    
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
        
        return cell
    }
}

//
//  AlbumCreateSection.swift
//  90s
//
//  Created by 김진우 on 2021/04/03.
//

import UIKit

struct AlbumCreateSection: AlbumSection {
    let numberOfItems = 1
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AlbumSectionItem) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCreateCollectionViewCell.identifier, for: indexPath) as! AlbumCreateCollectionViewCell
        switch item {
        case .statusCreate(let viewModel):
            cell.bind(viewModel: viewModel)
        default:
            break
        }
        return cell
    }
}

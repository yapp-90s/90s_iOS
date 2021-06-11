//
//  AlbumPreviewSection.swift
//  90s
//
//  Created by 김진우 on 2021/04/03.
//

import UIKit

struct AlbumPreviewSection: AlbumSection {
    let numberOfItems = 5
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(187))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AlbumSectionItem) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumPreviewCollectionViewCell.identifier, for: indexPath) as! AlbumPreviewCollectionViewCell
        switch item {
        case .statusPreview(let viewModel):
            cell.bind(viewModel: viewModel)
        default:
            break
        }
        return cell
    }
}

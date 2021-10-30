//
//  AlbumCoverSection.swift
//  90s
//
//  Created by 김진우 on 2021/04/03.
//

import UIKit

struct AlbumCoverSection: AlbumSection {
    let numberOfItems = 5
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.44), heightDimension: .absolute(190 * layoutScale))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = .init(16)
        section.contentInsets = .init(top: 0, leading: 18 * layoutScale, bottom: 0, trailing: 18 * layoutScale)
        
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AlbumSectionItem) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCoverCollectionViewCell.identifier, for: indexPath) as! AlbumCoverCollectionViewCell
        switch item {
        case .statusCover(let viewModel):
            cell.bind(viewModel: viewModel)
        default:
            break
        }
        
        return cell
    }
}

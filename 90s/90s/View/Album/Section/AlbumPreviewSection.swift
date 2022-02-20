//
//  AlbumPreviewSection.swift
//  90s
//
//  Created by 김진우 on 2021/04/03.
//

import UIKit

struct AlbumPreviewSection: AlbumSection {
    let numberOfItems = 4
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(187 * layoutScale))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 18 * layoutScale, bottom: 0, trailing: 18 * layoutScale)
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AlbumSectionItem) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumPreviewViewCell.identifier, for: indexPath) as! AlbumPreviewViewCell
        switch item {
        case .statusPreview(let viewModel):
            cell.bind(viewModel: .init(dependency: .init(album: viewModel.album)))
        default:
            break
        }
        return cell
    }
}

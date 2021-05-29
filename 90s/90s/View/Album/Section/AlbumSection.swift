//
//  AlbumSection.swift
//  90s
//
//  Created by 김진우 on 2021/04/03.
//

import UIKit

protocol AlbumSection {
    var numberOfItems: Int { get }
    func layoutSection() -> NSCollectionLayoutSection
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AlbumSectionItem) -> UICollectionViewCell
}

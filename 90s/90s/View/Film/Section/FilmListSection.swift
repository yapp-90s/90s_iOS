//
//  FilmMainSection.swift
//  90s
//
//  Created by 성다연 on 2021/06/11.
//

import UIKit

protocol FilmListSection {
    var numberOfItems : Int { get }
    func layoutSection() -> NSCollectionLayoutSection
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: FilmListSectionItem) -> UICollectionViewCell
}

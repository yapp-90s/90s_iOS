//
//  FilmPinterestCollectionViewLayout.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import UIKit

protocol FilmPinterestLayoutDelegate : AnyObject {
    func collectionView( _ collectionView : UICollectionView, heightForPhotoAtIndexPath indexPath : IndexPath) -> CGFloat
}

class FilmPinterestLayout: UICollectionViewLayout {
    weak var delegate : FilmPinterestLayoutDelegate?
    
    private let numberOfColumns = 2
    private var numberOfSections = 1
    
    private var cache : [UICollectionViewLayoutAttributes] = []

    private var contentHeight : CGFloat = 0
    private var contentWidth : CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        setUpPinterestLayout()
    }
    
    private func setUpPinterestLayout(){
        guard cache.isEmpty, let collectionView = collectionView else { return }
        numberOfSections = collectionView.numberOfSections
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset : [CGFloat] = []
        var yOffset : [CGFloat] = Array(repeating: 300, count: numberOfColumns)
        
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        
        let headerAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(item: 0, section: 0))
        headerAttribute.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 300)
        cache.append(headerAttribute)
      
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? 200
            let height = 12 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: 6, dy: 6)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    /// 주어진 사각형 내에 있는 모든 아이템들을 위한 레이아웃 속성을 반환해야한다
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibileLayoutAttributes : [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibileLayoutAttributes.append(attributes)
            }
        }
        
        return visibileLayoutAttributes
    }
    
    /// 요구된 레이아웃 정보를 collectionView로 제공
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}

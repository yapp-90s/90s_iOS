//
//  FilmPinterestCollectionViewLayout.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import UIKit

/// 높이 기준으로 사진을 나열한 콜렉션 레이아웃
protocol PinterestLayoutDelegate : AnyObject {
    func collectionView( _ collectionView : UICollectionView, heightForPhotoAtIndexPath indexPath : IndexPath) -> CGFloat
}

// 사용시 heightForPhotoAtIndexPath 함수로 이미지 높이 지정
final class PinterestLayout: UICollectionViewLayout {
    weak var delegate : PinterestLayoutDelegate?
    
    private var headerHeight : CGFloat = 300
    private let numberOfColumns = 2
    private var cache : [UICollectionViewLayoutAttributes] = []

    private var contentHeight : CGFloat = 0
    private var contentWidth : CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    init(headerHeight: CGFloat) {
        self.headerHeight = headerHeight
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: contentWidth, height: contentHeight)
        }
    }
    
    override func prepare() {
        setUpPinterestLayout()
    }
    
    private func setUpPinterestLayout(){
        guard cache.isEmpty, let collectionView = collectionView else { return }
    
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset : [CGFloat] = []
        var yOffset : [CGFloat] = Array(repeating: headerHeight, count: numberOfColumns)
        
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        
        let headerAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(item: 0, section: 0))
        headerAttribute.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: headerHeight)
        cache.append(headerAttribute)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            guard let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) else {
                print("PinterestLayout : Unable to bring height of image")
                return
            }
            let height = 12 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
           
            let insetFrame = item % 2 == 0 ?
                frame.inset(by: UIEdgeInsets(top: 4, left: 18, bottom: 4, right: 4)) :
                frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 18))
            
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
        
        for attributes in cache where rect.intersects(attributes.frame) {
            visibileLayoutAttributes.append(attributes)
        }
        
        return visibileLayoutAttributes
    }
    
    /// 요구된 레이아웃 정보를 CollectionView로 제공
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}

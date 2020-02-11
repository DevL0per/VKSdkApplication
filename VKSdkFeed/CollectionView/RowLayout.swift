//
//  RowLayout.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 02/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

protocol RowLayoutDelegate {
    func collectionView(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewLayout {
    
    var delegate: RowLayoutDelegate!
    
    var cache: [UICollectionViewLayoutAttributes] = []
    var contentWidth: CGFloat = 0
    var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    static let cellPadding: CGFloat = 8
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        cache = []
        contentWidth = 0
        var photosSizes: [CGSize] = []
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(row: item, section: 0)
            let photoSize = delegate.collectionView(collectionView: collectionView, indexPath: indexPath)
            photosSizes.append(photoSize)
        }
        
        guard let photoHeight = RowLayout.getRowHeight(superViewWidth: collectionView.bounds.width,
                                             photosSizes: photosSizes) else { return }
        
        let ratios = photosSizes.map {(photoSize) in photoSize.width / photoSize.height }
        var xOffSet: CGFloat = 0
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(row: item, section: 0)
            let photoWidth = photoHeight * ratios[item]
            let frame = CGRect(origin: CGPoint(x: xOffSet, y: 0), size: CGSize(width: photoWidth, height: photoHeight))
            let insetFrame = frame.insetBy(dx: RowLayout.cellPadding, dy: RowLayout.cellPadding)
            let layoutAttribute =  UICollectionViewLayoutAttributes(forCellWith: indexPath)
            layoutAttribute.frame = insetFrame
            contentWidth = contentWidth+photoWidth
            cache.append(layoutAttribute)
            xOffSet += photoWidth
        }
        contentWidth += RowLayout.cellPadding
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var visibleAttributes = [UICollectionViewLayoutAttributes]()

        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleAttributes.append(attribute)
            }
        }
        
        return visibleAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    
    static func getRowHeight(superViewWidth: CGFloat, photosSizes: [CGSize]) -> CGFloat? {
        let minRatioPhoto = photosSizes.max {(first, second) -> Bool in
            (first.width/first.height) < (second.width/second.height)
        }
        guard let unwrappedMinRatioPhoto = minRatioPhoto else { return nil }
        let diffirence = superViewWidth / unwrappedMinRatioPhoto.width
        return unwrappedMinRatioPhoto.height *  diffirence
    }
    
}

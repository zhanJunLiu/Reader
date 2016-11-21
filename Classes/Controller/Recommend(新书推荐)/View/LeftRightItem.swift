//
//  LeftRightItem.swift
//  swift-左右滑动CollectionView
//
//  Created by 炳神 on 16/8/7.
//  Copyright © 2016年 as2482199. All rights reserved.
//

import UIKit

class LeftRightItem: UICollectionViewFlowLayout {

    override func prepareLayout() {
        super.prepareLayout()
        
        itemSize = CGSizeMake(SCREEN_W / 3, SCREEN_SCALE_HEIGHT * 360)
        scrollDirection = .Horizontal
        //设置内边距
        sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
}


extension LeftRightItem {
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        
        var rect : CGRect = CGRect()
        
        if let rectX : CGFloat = proposedContentOffset.x {
            rect.origin.x = rectX
        }
        
        if let y : CGFloat = 0.0 {
            rect.origin.y = y
        }
        
        if let rectS : CGSize = collectionView!.frame.size {
            rect.size = rectS
        }

        guard let array : [UICollectionViewLayoutAttributes] = super.layoutAttributesForElementsInRect(rect) else {
            return CGPoint()
        }
    
        // 计算CollectionView最中心点的x值
        let centerX = collectionView!.frame.size.width / 2 + proposedContentOffset.x
        
        var minDelta : CGFloat = CGFloat(MAXFLOAT)
        
        
        for attrs : UICollectionViewLayoutAttributes in array {
            
            if abs(minDelta) > abs(attrs.center.x - centerX) {
                
                minDelta = attrs.center.x - centerX
                
            }
            
            
        }
        
        var num : CGPoint = proposedContentOffset
        
        num.x += minDelta

        return num

    }
    
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array = super.layoutAttributesForElementsInRect(rect)
        
        let centerXX = collectionView!.contentOffset.x + collectionView!.frame.size.width / 2
        
        
        
        for attrs : UICollectionViewLayoutAttributes in array! {
            
             //cell的中心点x 和CollectionView最中心点的x值
            let detal : CGFloat = abs(attrs.center.x - centerXX)
            
            //根据间距值  计算cell的缩放的比例 小于1
            let scale : CGFloat = 1 - detal / collectionView!.frame.size.width
            
            attrs.transform = CGAffineTransformMakeScale(scale, scale)
            
        }
        
        return array
    }
    
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}

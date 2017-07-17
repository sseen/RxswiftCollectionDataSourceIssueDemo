//
//  RDHomeCollectionFlowLayout.swift
//  fakeLekeHomePage
//
//  Created by sseen on 2017/7/7.
//  Copyright © 2017年 sseen. All rights reserved.
//

import UIKit

class RDHomeCollectionFlowLayout: UICollectionViewFlowLayout {
    
    var datas:[NumberSection] = [NumberSection]()
    
    override var collectionViewContentSize:CGSize {
        
        let contentWidth = self.collectionView?.bounds.size.width
        let contentHeight = RD.CustomCollection.DayHeaderHeight * 2// (HeightPerHour * HoursPerDay)
        let contentSize = CGSize(width: contentWidth!, height: contentHeight)
        
//        if (collectionView?.numberOfSections)! < 1 { // <--- this is needed
//            return .zero
//        }
        
        return contentSize
    }

    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        if (self.collectionView?.numberOfSections ?? 0) < 1 { // <--- this is needed
            return []
        } else {
            
        }
        // Cells
        let attributesArray = super.layoutAttributesForElements(in: rect);
        guard self.collectionView != nil else {return attributesArray;}
        for attributes in attributesArray ?? [] {
            
            attributes.frame = CGRect(x: (self.itemWidth() + 1 ) * (CGFloat)(attributes.indexPath.item) ,
                                      y: RD.CustomCollection.HourHeaderWidth * (CGFloat)(attributes.indexPath.item % 4),
                                      width: self.itemWidth(),
                                      height: RD.CustomCollection.HourHeaderWidth)
            
            layoutAttributes.append(attributes)
        }
        
        
        print("\(layoutAttributes.count)")
        
        return layoutAttributes
    }
    
    func itemWidth() -> CGFloat {
        let items:CGFloat = 4
        let width = ( K.ViewSize.SCREEN_WIDTH - (items - 1) ) / items
        return width
    }
}

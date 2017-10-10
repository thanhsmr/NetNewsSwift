//
//  PinterestLayout.swift
//  PinterestLayout
//
//  Created by Le Thi Van Anh on 2/25/17.
//  Copyright © 2017 Le Thi Van Anh. All rights reserved.
//

import UIKit


class PinterestLayout: UICollectionViewLayout {
    let attributeArray = NSMutableDictionary()
    var contentSize:CGSize!
    var delegate:PinterestLayoutDelegate!
    var padding: CGFloat = 0.0
    
    override init() {
        super.init()
        
    }
    
    init(padding: CGFloat) {
        super.init()
        self.padding = padding
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepare()
    {
        super.prepare()
        if self.collectionView?.numberOfItems(inSection: 0) == 0 {
            return
        }
        self.attributeArray.removeAllObjects()
        let numberOfColumn : Int = self.delegate.getNumberOfColumn();
        
        let collectionViewWidth = self.collectionView?.frame.size.width
        let itemWidth : CGFloat = (collectionViewWidth! - padding * CGFloat((numberOfColumn + 1))) / CGFloat(numberOfColumn)
        var contentHeight:CGFloat = 0.0;
        var columnArray = [CGFloat](repeating: 0.0, count: numberOfColumn);
        
        //Tính toán kích thước và vị trí của từng cell trong CollectionView
        for i in 0 ... (self.collectionView?.numberOfItems(inSection: 0))! - 1 {
            var tempX : CGFloat = 0.0
            var tempY : CGFloat = 0.0
            let indexPath = NSIndexPath(item: i, section: 0)
            let itemHeight:CGFloat = delegate.collectionView(collectionView: (self.collectionView)!, heightForPhotoAtIndexPath: indexPath)
            
            //Tìm cột có độ dài ngắn nhất trong CollectionView
            var minHeight:CGFloat = 0.0;
            var minIndex:Int = 0;
            
            if (numberOfColumn > 0){
                minHeight = columnArray[0]
                
            }
            for colIndex in 0..<numberOfColumn {
                if (minHeight > columnArray[colIndex]){
                    minHeight = columnArray[colIndex]
                    minIndex = colIndex
                }
            }
            
            //Bổ sung  cell mới vào cột có kích thước ngắn nhất
            tempX = padding + (itemWidth + padding) *  CGFloat(minIndex);
            tempY = minHeight + padding;
            columnArray[minIndex] = tempY + itemHeight;
            let attributes = UICollectionViewLayoutAttributes(forCellWith:indexPath as IndexPath);
            attributes.frame = CGRect(x: tempX, y: tempY, width: itemWidth, height: itemHeight);
            self.attributeArray.setObject(attributes, forKey: indexPath)
            
            //Tính toán lại chiều cao Content Size của CollectionView
            let newContentHeight:CGFloat = tempY + padding + itemHeight + padding;
            if (newContentHeight > contentHeight){
                contentHeight = newContentHeight;
            }
        }
        
        self.contentSize = CGSize(width: (self.collectionView?.frame.size.width)!, height: contentHeight);
    }
    
    override var collectionViewContentSize: CGSize
    {
        if self.collectionView?.numberOfItems(inSection: 0) == 0 {
            return CGSize.zero
        } else {
            return self.contentSize
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Duyệt các đối tượng trong attributeArray để tìm ra các cell nằm trong khung nhìn rect
        for attributes  in self.attributeArray {
            if (attributes.value as! UICollectionViewLayoutAttributes).frame.intersects(rect ) {
                layoutAttributes.append((attributes.value as! UICollectionViewLayoutAttributes))
            }
        }
        return layoutAttributes
    }
    
    
}

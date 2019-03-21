//
//  SKCollectionViewXScrollView.swift
//  SKCollectionView
//
//  Created by Suat Karakusoglu on 12/15/17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import Foundation

extension SKCollectionView
{
    public func skScrollViewDidEndDragging(_ block: @escaping () -> Void) {
        self.blockScrollViewDidEndDragging = block
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.blockScrollViewDidEndDragging?()
    }
    
    public func skOnScrollViewDidScroll(_ block: @escaping () -> Void)
    {
        self.blockScrollViewDidScroll = block
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        self.blockScrollViewDidScroll?()
    }
    
    public func skOnScrollViewDidEndDecelerating(_ block: @escaping () -> Void)
    {
        self.blockScrollViewDidEndDecelerating = block
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        if self.isPagingEnabled
        {
            let x = self.contentOffset.x
            let w = self.bounds.size.width
            let currentPage = Int(ceil(x/w))
            self.blockOnPageChanged?(currentPage)
        }
        
        self.blockScrollViewDidEndDecelerating?()
    }
    
    public func skEnablePaging(_ block: @escaping (_ page: Int) -> Void)
    {
        self.isPagingEnabled = true
        self.blockOnPageChanged = block
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        guard let itemWidth = self.customPagingItemWidth else { return }
        
        let pageWidth = Float(itemWidth)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(self.contentSize.width)
        var newPage = Float(self.customCurrentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.customCurrentPage + 1 : self.customCurrentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.customCurrentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
}

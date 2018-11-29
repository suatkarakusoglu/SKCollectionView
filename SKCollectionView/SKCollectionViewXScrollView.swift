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
}

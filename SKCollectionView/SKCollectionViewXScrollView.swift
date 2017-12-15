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
    public func onScrollViewDidScroll(_ block: @escaping () -> Void)
    {
        self.blockScrollViewDidScroll = block
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        self.blockScrollViewDidScroll?()
    }
}

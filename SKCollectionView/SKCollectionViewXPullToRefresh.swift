//
//  SKCollectionViewXPullToRefresh.swift
//  Zamekan
//
//  Created by suat.karakusoglu on 11.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
extension SKCollectionView
{
    open func skSetRefreshControl(blockRefresh: @escaping () -> Void, refreshMessage: String? = nil)
    {
        self.refreshControl?.removeFromSuperview()
        self.refreshControl = nil
        
        self.blockPullToRefresh = blockRefresh
        let refreshControlForSK = UIRefreshControl()
        if let refreshMessage = refreshMessage {
            refreshControlForSK.attributedTitle = NSAttributedString(string: refreshMessage)
        }
        refreshControlForSK.addTarget(
            self,
            action: #selector(SKCollectionView.refresh),
            for: UIControlEvents.valueChanged
        )
        
        self.refreshControl = refreshControlForSK
        self.addSubview(self.refreshControl!)
    }
    
    @objc func refresh()
    {
        self.blockPullToRefresh?()
        self.refreshControl?.endRefreshing()
    }
}

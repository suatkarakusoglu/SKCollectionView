//
//  SKCollectionViewXPullToRefresh.swift
//  Zamekan
//
//  Created by suat.karakusoglu on 11.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

extension SKCollectionView
{
    open func skSetRefreshControl(refreshMessage: String? = nil, _ blockRefresh: @escaping () -> Void)
    {
        self.blockPullToRefresh = blockRefresh
        let refreshControlForSK = UIRefreshControl()
        
        if let refreshMessage = refreshMessage {
            refreshControlForSK.attributedTitle = NSAttributedString(string: refreshMessage)
        }
        
        refreshControlForSK.addTarget(
            self,
            action: #selector(SKCollectionView.refresh),
            for: UIControl.Event.valueChanged
        )
        
        if #available(iOS 10.0, *) {
            self.refreshControl?.removeFromSuperview()
            self.refreshControl = nil
            self.refreshControl = refreshControlForSK
        } else {
            self.refreshControlForLowerThaniOS10 = refreshControlForSK
            self.addSubview(refreshControlForSK)
        }
    }
    
    @objc func refresh()
    {
        self.blockPullToRefresh?()
        if #available(iOS 10.0, *)
        {
            self.refreshControl?.endRefreshing()
        }
        else
        {
            self.refreshControlForLowerThaniOS10?.removeFromSuperview()
        }
    }
}

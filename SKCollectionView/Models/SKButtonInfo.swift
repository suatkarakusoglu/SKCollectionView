//
//  SKButtonInfo.swift
//  SKCollectionView
//
//  Created by Suat Karakusoglu on 12/3/17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

open class SKButtonInfo
{
    let title: String
    let actionBlock: () -> Void

    open var backgroundColor: UIColor?
    open var foregroundColor: UIColor?
    open var font: UIFont?
    
    public init(title: String, actionBlock: @escaping () -> Void)
    {
        self.title = title
        self.actionBlock = actionBlock
    }
}

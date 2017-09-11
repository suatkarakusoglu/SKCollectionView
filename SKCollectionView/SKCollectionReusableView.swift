//
//  SKCollectionReusableView.swift
//  SKCollection
//
//  Created by Suat Karakusoglu on 1/29/17.
//  Copyright © 2017 sk. All rights reserved.
//

import UIKit

open class SKCollectionReusableView: UICollectionReusableView
{
    var reusableModel: SKCollectionReusableModel?
    
    open func applyReusableModel(reusableModel: SKCollectionReusableModel)
    {
        self.reusableModel = reusableModel
    }
    
    open func getReusableModel<T: SKCollectionReusableModel>() -> T
    {
        return self.reusableModel as! T
    }
}

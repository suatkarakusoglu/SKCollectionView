//
//  SKCollectionCell.swift
//  SKCollection
//
//  Created by Suat Karakusoglu on 1/29/17.
//  Copyright © 2017 sk. All rights reserved.
//

import UIKit

open class SKCollectionCell: UICollectionViewCell
{
    var model: SKCollectionModel?
    
    open func applyModel(kollectionModel: SKCollectionModel)
    {
        self.model = kollectionModel
    }
    
    open func getModel<T: SKCollectionModel>() -> T
    {
        return self.model as! T
    }
}

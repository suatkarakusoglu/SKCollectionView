//
//  SKEndlessCModel.swift
//  SKCollectionView
//
//  Created by Suat Karakusoglu on 12/15/17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

class SKEndlessCModel: SKCollectionModel
{
    let loadingSize: CGSize
    
    public init(loadingSize: CGSize)
    {
        self.loadingSize = loadingSize
    }
    
    override func cellType() -> SKCollectionCell.Type
    {
        return SKEndlessCCell.self
    }
    
    override func cellSize() -> CGSize
    {
        return self.loadingSize
    }
}

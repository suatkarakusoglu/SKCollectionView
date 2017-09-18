//
//  SKEndlessCModel.swift
//  SKCollectionView
//
//  Created by suat.karakusoglu on 19.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import Foundation

public class SKEndlessCModel: SKCollectionModel
{
    let loadingImage: UIImage
    let loadingSize: CGSize
    
    public init(loadingSize: CGSize, loadingImage: UIImage? = nil)
    {
        self.loadingSize = loadingSize
        if let loadingImage = loadingImage {
            self.loadingImage = loadingImage
        }else {
            let defaultLoadingImage = UIImage(named:"loading", in: SKCollectionView.skBundle, compatibleWith: nil)!
            self.loadingImage = defaultLoadingImage
        }
    }
    
    override public func cellType() -> SKCollectionCell.Type
    {
        return SKEndlessCCell.self
    }
    
    override public func cellSize() -> CGSize
    {
        return self.loadingSize
    }
}

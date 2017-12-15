//
//  SKCollectionEmptyCaseCModel.swift
//  SKCollectionView
//
//  Created by Suat Karakusoglu on 12/3/17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

class SKCollectionEmptyCaseCModel: SKCollectionModel
{
    let imageIcon: UIImage
    let title: NSAttributedString
    let subTitle: NSAttributedString
    let height: CGFloat
    let buttonInfo: SKButtonInfo?
    
    init(imageIcon: UIImage,
         title: NSAttributedString,
         subTitle: NSAttributedString,
         height: CGFloat,
         buttonInfo: SKButtonInfo?)
    {
        self.imageIcon = imageIcon
        self.title = title
        self.subTitle = subTitle
        self.height = height
        self.buttonInfo = buttonInfo
    }
    
    override func cellType() -> SKCollectionCell.Type
    {
        return SKCollectionEmptyCaseCCell.self
    }
    
    override func cellSize() -> CGSize
    {
        let realWidth: CGFloat = UIScreen.main.bounds.size.width
        let realHeight: CGFloat = self.height
        return CGSize(width: realWidth, height: realHeight)
    }
}

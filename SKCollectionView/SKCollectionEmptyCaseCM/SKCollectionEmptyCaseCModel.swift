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
    let cellHeight: CGFloat
    let buttonInfo: SKButtonInfo?
    
    init(imageIcon: UIImage,
         title: NSAttributedString,
         subTitle: NSAttributedString,
         buttonInfo: SKButtonInfo?,
         cellHeight: CGFloat)
    {
        self.imageIcon = imageIcon
        self.title = title
        self.subTitle = subTitle
        self.buttonInfo = buttonInfo
        self.cellHeight = cellHeight
    }
    
    override func cellType() -> SKCollectionCell.Type
    {
        return SKCollectionEmptyCaseCCell.self
    }
    
    override func cellSize() -> CGSize
    {
        let realWidth: CGFloat = UIScreen.main.bounds.size.width
        let realHeight: CGFloat = self.cellHeight
        return CGSize(width: realWidth, height: realHeight)
    }
}

//
//  SKEmptyCaseInfo.swift
//  SKCollectionView
//
//  Created by Suat Karakusoglu on 12/3/17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import Foundation

open class SKEmptyCaseInfo
{
    let image: UIImage
    let title: NSAttributedString
    let subTitle: NSAttributedString
    let buttonInfo: SKButtonInfo?
    
    public init(
        image: UIImage,
        title: NSAttributedString,
        subTitle: NSAttributedString,
        buttonInfo: SKButtonInfo?)
    {
        self.image = image
        self.title = title
        self.subTitle = subTitle
        self.buttonInfo = buttonInfo
    }
    
    public convenience init(
        image: UIImage,
        title: String,
        subTitle: String,
        buttonInfo: SKButtonInfo?)
    {
        let title = NSAttributedString(string: title)
        let subTitle = NSAttributedString(string: subTitle)
        self.init(image: image, title: title, subTitle: subTitle, buttonInfo: buttonInfo)
    }
}

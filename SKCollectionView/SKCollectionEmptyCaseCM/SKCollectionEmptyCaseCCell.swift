//
//  SKCollectionEmptyCaseCCell.swift
//  SKCollectionView
//
//  Created by Suat Karakusoglu on 12/3/17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

class SKCollectionEmptyCaseCCell: SKCollectionCell
{
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func applyModel(kollectionModel: SKCollectionModel)
    {
        guard let model = kollectionModel as? SKCollectionEmptyCaseCModel else { return }
        super.applyModel(kollectionModel: model)
        self.imageViewIcon.image = model.imageIcon
        self.labelTitle.attributedText = model.title
        self.labelSubTitle.attributedText = model.subTitle
        self.setButtonInfoProperties()
    }
    
    private func setButtonInfoProperties()
    {
        guard let buttonInfo = self.getCollectionModel().buttonInfo else { return }
        
        if let foregroundColor = buttonInfo.foregroundColor {
            self.buttonAction.setTitleColor(foregroundColor, for: .normal)
        }
        
        if let backgroundColor = buttonInfo.backgroundColor {
            self.buttonAction.backgroundColor = backgroundColor
        }
        
        if let font = buttonInfo.font {
            self.buttonAction.titleLabel?.font = font
        }
        
        self.buttonAction.setTitle(buttonInfo.title, for: .normal)
    }
    
    @IBAction func actionEmptyCase(_ sender: UIButton)
    {
        self.getCollectionModel().buttonInfo?.actionBlock()
    }
    
    func getCollectionModel() -> SKCollectionEmptyCaseCModel
    {
        return self.getModel()
    }
}

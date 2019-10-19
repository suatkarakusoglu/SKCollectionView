//
//  SKEndlessCCell.swift
//  SKCollectionView
//
//  Created by Suat Karakusoglu on 12/15/17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

class SKEndlessCCell: SKCollectionCell
{
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func applyModel(kollectionModel: SKCollectionModel)
    {
        guard let model = kollectionModel as? SKEndlessCModel else { return }
        super.applyModel(kollectionModel: model)
        self.activityIndicatorView.startAnimating()
    }
}

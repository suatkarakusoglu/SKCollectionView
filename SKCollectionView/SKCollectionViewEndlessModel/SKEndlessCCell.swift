//
//  SKEndlessCCell.swift
//  SKCollectionView
//
//  Created by suat.karakusoglu on 19.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

class SKEndlessCCell: SKCollectionCell
{
    @IBOutlet weak var imageViewLoading: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func applyModel(kollectionModel: SKCollectionModel)
    {
        guard let model = kollectionModel as? SKEndlessCModel else { return }
        super.applyModel(kollectionModel: model)
        self.imageViewLoading.image = model.loadingImage
        self.addLoadingScrollAnimationToView(view: self.imageViewLoading)
    }
    
    private func addLoadingScrollAnimationToView(view: UIView)
    {
        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        basicAnimation.toValue = NSNumber(value: .pi * 2.0 * 1.0 * 1.0)
        basicAnimation.duration = 1
        basicAnimation.isCumulative = true
        basicAnimation.repeatCount = 100
        view.layer.add(basicAnimation, forKey: "rotationAnimation")
    }
}

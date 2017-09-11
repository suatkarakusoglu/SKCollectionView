//
//  SKCollectionModelProtocol.swift
//  N11
//
//  Created by suat.karakusoglu on 06/04/2017.
//  Copyright © 2017 N11.com. All rights reserved.
//

import UIKit

protocol SKCollectionModelProtocol
{
    func cellSize() -> CGSize
    func cellType() -> SKCollectionCell.Type
    func cellSelected()
}

//
//  SKExtensions.swift
//  SKCollectionView
//
//  Created by suat.karakusoglu on 11.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

extension Bundle
{
    static func skFrameworkBundle() -> Bundle
    {
        let bundle = Bundle(for: SKCollectionView.self)
        guard let path = bundle.path(forResource: "SKCollectionView", ofType: "bundle") else { return bundle }
        return Bundle(path: path)!
    }
}

extension Sequence
{
    public func skFindFirst(predicate: (Element) -> Bool) -> Element?
    {
        return self.filter{ predicate($0) }.first
    }
}

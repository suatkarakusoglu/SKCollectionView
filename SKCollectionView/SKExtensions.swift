//
//  SKExtensions.swift
//  SKCollectionView
//
//  Created by suat.karakusoglu on 11.09.17.
//  Copyright © 2017 suat.karakusoglu. All rights reserved.
//

import UIKit

extension Sequence
{
    public func skFindFirst(predicate: (Element) -> Bool) -> Element?
    {
        return self.filter{ predicate($0) }.first
    }
}

extension String
{
    public static func skRandomString(length:Int) -> String
    {
        let randomString:NSMutableString = NSMutableString(capacity: length)
        let letters:NSMutableString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var i: Int = 0
        while i < length {
            let randomIndex:Int = Int(arc4random_uniform(UInt32(letters.length)))
            randomString.append("\(Character( UnicodeScalar( letters.character(at: randomIndex))!))")
            i += 1
        }
        return String(randomString)
    }
}

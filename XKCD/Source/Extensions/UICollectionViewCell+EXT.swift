//
//  UICollectionViewCell+EXT.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import UIKit

extension UICollectionViewCell{
    static var reuseID: String {
        String(describing: self)
    }
}

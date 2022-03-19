//
//  UItableViewCell+EXT.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-18.
//

import UIKit

extension UITableViewCell {
    static var reuseID: String {
        String(describing: self)
    }
}

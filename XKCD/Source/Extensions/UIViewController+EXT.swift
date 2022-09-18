//
//  UIViewController+EXT.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-19.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
}

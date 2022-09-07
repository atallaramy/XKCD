//
//  UIImageView+EXT.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import UIKit

extension UIImageView {
    func loadResizeAndCache(url: URL, targetWidth: CGFloat? = nil, targetHeight: CGFloat? = nil) {
        let cache = NSCache<NSString, UIImage>()
        let urlString = url.absoluteString as NSString
        if let image = cache.object(forKey: urlString) {
            self.image = image
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    if let targetWidth = targetWidth {
                        let resized = image.resizeToFitMainComicView(targetWidth: targetWidth)
                        DispatchQueue.main.async {
                            self?.image = resized
                        }
                    }
                    if let targetHeight = targetHeight {
                        let resized = image.resizeToFitDetailComicView(targetHeight: targetHeight)
                        DispatchQueue.main.async {
                            self?.image = resized
                        }
                    }
                    cache.object(forKey: urlString)
                }
            }
        }
    }
}


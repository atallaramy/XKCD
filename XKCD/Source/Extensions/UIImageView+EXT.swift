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
            if let targetWidth = targetWidth {
                let resizedImage = image.resize(width: targetWidth)
                self.setImageOnMainThread(image: resizedImage)
            }
            if let targetHeight = targetHeight {
                let resizedImage = image.resize(height: targetHeight)
                self.setImageOnMainThread(image: resizedImage)
            }
        } else {
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            cache.setObject(image, forKey: urlString)
            if let targetWidth = targetWidth {
                let resizedImage = image.resize(width: targetWidth)
                self.setImageOnMainThread(image: resizedImage)
            }
            if let targetHeight = targetHeight {
                let resizedImage = image.resize(height: targetHeight)
                self.setImageOnMainThread(image: resizedImage)
            }
        }
    }
    
    
    func setImageOnMainThread(image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}


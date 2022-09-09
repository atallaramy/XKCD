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
        let urlStringForMainPage = url.absoluteString + "1" as NSString
        let urlStringForDetailPage = url.absoluteString + "2" as NSString
        
        if let targetWidth = targetWidth {
            guard targetHeight == nil else {
                assertionFailure("you can have targetWidth or targetHeight but not both at the same time")
                return }
            if let image = cache.object(forKey: urlStringForMainPage) {
                setImageOnMainThread(image: image)
                return
            }

            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            guard let resized = image.resizeToFitMainComicView(targetWidth: targetWidth) else { return }
            setImageOnMainThread(image: resized)
            cache.setObject(resized, forKey: urlStringForMainPage)
        }
        
        if let targetHeight = targetHeight {
            guard targetWidth == nil else {
                assertionFailure("you can have targetWidth or targetHeight but not both at the same time")
                return }
            if let image = cache.object(forKey: urlStringForDetailPage) {
                setImageOnMainThread(image: image)
                return
            }
            
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            guard let resized = image.resizeToFitDetailComicView(targetHeight: targetHeight) else { return }
            setImageOnMainThread(image: resized)
            cache.setObject(resized, forKey: urlStringForDetailPage)

        }
    }
    
    func setImageOnMainThread(image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}


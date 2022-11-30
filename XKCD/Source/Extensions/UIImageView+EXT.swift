//
//  UIImageView+EXT.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import UIKit

extension UIImageView {
    func loadResizeAndCache(url: URL, targetWidth: CGFloat? = nil, targetHeight: CGFloat? = nil) async throws {
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
            
            let image = try await fetchAndLoadImage(url: url)
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
    
    func fetchAndLoadImage(url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300) ~= httpResponse.statusCode else {
            throw XkcdError.invalidResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw XkcdError.unsupportedImage
        }
        
        return image
    }
}




//
//  UIImage+EXT.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-16.
//

import UIKit

extension UIImage {
    func resizeToFitMainComicView(targetWidth: CGFloat) -> UIImage? {
        let size = self.size
        
        let widthRatio = targetWidth / size.width
        
        var newSize: CGSize
        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func resizeToFitDetailComicView(targetHeight: CGFloat) -> UIImage? {
        let size = self.size
        
        let heightRatio = targetHeight / size.height
        
        var newSize: CGSize
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

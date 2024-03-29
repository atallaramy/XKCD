//
//  UIView+EXT.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import UIKit

extension UIView {
    
    func anchor(top:    NSLayoutYAxisAnchor? = nil,
                left:   NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right:  NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                widthConstrain: NSLayoutDimension? = nil,
                height: CGFloat? = nil,
                heightConstrain: NSLayoutDimension? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let widthConstrain = widthConstrain {
            widthAnchor.constraint(equalTo: widthConstrain).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let heightConstrain = heightConstrain {
            heightConstrain.constraint(equalTo: heightConstrain).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.45
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
    }
    
    func pinToEdges(of superView: UIView) {
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superView.topAnchor),
                leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                trailingAnchor.constraint(equalTo: superView.trailingAnchor),
                bottomAnchor.constraint(equalTo: superView.bottomAnchor)
            ])
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width: NSLayoutAnchor<NSLayoutDimension>) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: width).isActive = true
    }
}

//
//  DetailLabel.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-18.
//

import UIKit

class DetailLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat, weight: UIFont.Weight, height: CGFloat? = nil, backgroundColor: UIColor = .white) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.backgroundColor = backgroundColor
        if let height = height {
            anchor(height: height)
        }
    }
    
    fileprivate func configure() {
        layer.cornerRadius = 8
        clipsToBounds = true
        textAlignment = .center
        numberOfLines = 0
    }
    
}

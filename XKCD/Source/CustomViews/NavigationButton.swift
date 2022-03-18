//
//  NavigationButton.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-16.
//

import UIKit

final class NavigationButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, target: Any?, action: Selector) {
        self.init()
        self.setTitle(title, for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
        configure()
    }
    
    private func configure() {
        tintColor = .white
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        contentHorizontalAlignment = .center
        backgroundColor = .systemGray3
        anchor(height: 44)
        layer.cornerRadius = 4
        clipsToBounds = true
    }
}

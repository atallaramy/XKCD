//
//  NavigationButton.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-16.
//

import UIKit

final class ComicNavigationButton: UIButton {
    
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
        addAnimationsTargets()
        performRigidImpactFeedBack()
        style()
    }
    
    private func style() {
        tintColor = .white
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        contentHorizontalAlignment = .center
        backgroundColor = .systemGray
        anchor(height: 44)
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    private func addAnimationsTargets() {
        addTarget(self, action: #selector(down), for: .touchDown)
        addTarget(self, action: #selector(up), for: .touchUpInside)
        addTarget(self, action: #selector(upOutside), for: .touchUpOutside)
    }
    
    @objc private func down() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.titleLabel?.alpha = 0.3
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.performRigidImpactFeedBack()
        })
    }
    
    
    @objc private func up() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.titleLabel?.alpha = 1
            self.transform = .identity
            self.performRigidImpactFeedBack()
        })
    }
    
    @objc private func upOutside() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.titleLabel?.alpha = 1
            self.transform = .identity
        })
    }
    
    private func performRigidImpactFeedBack() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
}


//
//  ComicNavigationBar.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-16.
//

import UIKit

protocol NavigationBarDelegate: AnyObject {
    func fetchRandomComic()
    func fetchNextComic()
    func fetchPreviousComic()
    func fetchOldesComic()
    func fetchNewestComic()
}

class NavigationBar: UIView {
    weak var delegate: NavigationBarDelegate?
    
    lazy var randomComicButton = NavigationButton(title: "Random", target: self, action: #selector(fetchRandomComic))
    lazy var nextComicButton = NavigationButton(title: "Next>", target: self, action: #selector(fetchNextComic))
    lazy var previousComicButton = NavigationButton(title: "<Prev", target: self, action: #selector(fetchPreviousComic))
    lazy var oldestComicButton = NavigationButton(title: "|<", target: self, action: #selector(fetchOldestComic))
    lazy var newestComicButton = NavigationButton(title: ">|", target: self, action: #selector(fetchNewestComic))
    

    //MARK: Selectors
    @objc func fetchRandomComic() {
        delegate?.fetchRandomComic()
    }
    
    @objc func fetchNextComic() {
        delegate?.fetchNextComic()
    }
    
    @objc func fetchPreviousComic(){
        delegate?.fetchPreviousComic()
    }
    
    @objc func fetchOldestComic() {
        delegate?.fetchOldesComic()
    }
    
    @objc func fetchNewestComic() {
        delegate?.fetchNewestComic()
    }
    
    
    //MARK: Helpers
    
    private func configureUI() {
        let stack = UIStackView(arrangedSubviews: [oldestComicButton, previousComicButton, randomComicButton, nextComicButton, newestComicButton])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
}

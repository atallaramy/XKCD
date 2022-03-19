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
    func fetchOldestComic()
    func fetchNewestComic()
}

class ComicNavigationBar: UIView {
    //MARK: Properties
    weak var delegate: NavigationBarDelegate?
    
    lazy var randomComicButton = ComicNavigationButton(title: "Random", target: self, action: #selector(fetchRandomComic))
    lazy var nextComicButton = ComicNavigationButton(title: "Next>", target: self, action: #selector(fetchNextComic))
    lazy var previousComicButton = ComicNavigationButton(title: "<Prev", target: self, action: #selector(fetchPreviousComic))
    lazy var oldestComicButton = ComicNavigationButton(title: "|<", target: self, action: #selector(fetchOldestComic))
    lazy var newestComicButton = ComicNavigationButton(title: ">|", target: self, action: #selector(fetchNewestComic))
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

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
        delegate?.fetchOldestComic()
    }
    
    @objc func fetchNewestComic() {
        delegate?.fetchNewestComic()
    }
    
    
    //MARK: Helpers
    
    private func configureUI() {
        let stack = UIStackView(arrangedSubviews: [oldestComicButton, previousComicButton, randomComicButton, nextComicButton, newestComicButton])
        stack.axis = .horizontal
        stack.spacing = 6
        stack.distribution = .fillProportionally
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
}

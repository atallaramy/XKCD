//
//  ComicCell.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import UIKit

class ComicCell: UICollectionViewCell {
    
    //MARK: Properties
    
    lazy var imageVw: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .systemGray3
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return titleLabel
    }()
    
    var comic: Comic? {
        didSet { Task { await configure() }}}
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    private func configure() async {
        guard let url = comic?.image else { return }
        Task {
            try await imageVw.loadResizeAndCache(url: url, targetWidth: UIScreen.main.bounds.width)
            titleLabel.text = comic?.title
        }
    }
    
    private func layout() {
        addSubview(imageVw)
        imageVw.center = center
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
        titleLabel.anchor(top: topAnchor)
        titleLabel.setWidth(width: self.widthAnchor)
        imageVw.anchor(top: titleLabel.bottomAnchor)
        imageVw.centerX(inView: self)
    }
}

//
//  DetailCell.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-18.
//

import UIKit

class DetailCell: UITableViewCell {
    //MARK: Properties
    var comic: Comic? {
        didSet {
            configure()
        }
    }
    
    let titleAndNubmerLabel = DetailLabel(fontSize: 24, weight: .bold, height: 28)
    let dateLabel = DetailLabel(fontSize: 24, weight: .bold, height: 28)
    lazy var comicImageView: UIImageView = {
        let imView = UIImageView()
        imView.anchor(height: 100)
        return imView
    }()
    
    let transcriptTitleLabel = DetailLabel(fontSize: 20, weight: .bold)
    let transcriptLabel = DetailLabel(fontSize: 16, weight: .light)
    let explainationTitleLabel = DetailLabel(fontSize: 20, weight: .bold)
    let explainationLabel = DetailLabel(fontSize: 16, weight: .light)
    let cellView = UIView()
    
    
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Helpers
    private func configure() {
        transcriptTitleLabel.text = "Transcript"
        explainationTitleLabel.text = "Explaination"
        guard let comic = comic else { return }
        
        let titleAndNumberText = "#\(comic.num):_\(comic.title)"
        titleAndNubmerLabel.text = titleAndNumberText
        let dateText = "\(comic.day ?? "")/\(comic.month ?? "")/\(comic.year ?? "")"
        dateLabel.text = dateText
        comicImageView.loadResizeAndCache(url: comic.image, targetHeight: 100)
        transcriptLabel.text = comic.transcript == "" ? "No transcript available" : comic.transcript
    }
    
    private func configureUI() {
        let padding: CGFloat = 16
        let stack = UIStackView(arrangedSubviews: [titleAndNubmerLabel, dateLabel, comicImageView, transcriptTitleLabel, transcriptLabel, explainationTitleLabel, explainationLabel])
        backgroundColor = .systemGray4
        cellView.addSubview(stack)
        stack.axis = .vertical
        stack.alignment = .center
        stack.setCustomSpacing(padding, after: dateLabel)
        stack.setCustomSpacing(padding, after: comicImageView)
        stack.setCustomSpacing(padding, after: transcriptLabel)
        addSubview(cellView)
        stack.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: cellView.bottomAnchor, right: cellView.rightAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding)
        cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingBottom: padding)
        
    }
}

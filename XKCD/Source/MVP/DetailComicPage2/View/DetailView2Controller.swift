//
//  DetailView2Controller.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-09-06.
//

import UIKit

class DetailView2Controller: UIViewController {

    //  MARK: - Properties
    var presenter: Detail2Presenter!
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return  button
    }()
    
    let titleAndNubmerLabel = DetailLabel(fontSize: 24, weight: .bold, height: 28)
    let dateLabel = DetailLabel(fontSize: 24, weight: .bold, height: 28)
    let comicImageView = UIImageView()
    let transcriptTitleLabel = DetailLabel(fontSize: 20, weight: .bold)
    let transcriptLabel = DetailLabel(fontSize: 16, weight: .light)
    let explainationTitleLabel = DetailLabel(fontSize: 20, weight: .bold)
    let explainationLabel = DetailLabel(fontSize: 16, weight: .light)
    
    let scrollView = UIScrollView(frame: .zero)
    let contentView = UIView(frame: .zero)
    
    //  MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
        presenter.setComic()
    }
    
    //  MARK: - Selectors
    @objc func dismissView() {
        presenter.dismiss()
    }
    
    //  MARK: - Helpers
    private func configure() {
        transcriptTitleLabel.text = "Transcript"
        explainationTitleLabel.text = "Explaination"
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray4
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.anchor(top: view.topAnchor,
                          left: view.leftAnchor,
                          bottom: view.bottomAnchor,
                          right: view.rightAnchor)
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.anchor(top: scrollView.contentLayoutGuide.topAnchor,
                         left: scrollView.contentLayoutGuide.leftAnchor,
                         bottom: scrollView.contentLayoutGuide.bottomAnchor,
                         right: scrollView.contentLayoutGuide.rightAnchor,
                         widthConstrain: view.widthAnchor)
        
        let padding: CGFloat = 16
        let stack = UIStackView(arrangedSubviews: [titleAndNubmerLabel,
                                                   dateLabel,
                                                   comicImageView,
                                                   transcriptTitleLabel,
                                                   transcriptLabel,
                                                   explainationTitleLabel,
                                                   explainationLabel])
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.setCustomSpacing(padding, after: dateLabel)
        stack.setCustomSpacing(padding, after: comicImageView)
        stack.setCustomSpacing(padding, after: transcriptLabel)
        stack.anchor(top: contentView.topAnchor,
                     left: contentView.leftAnchor,
                     bottom: contentView.bottomAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: padding,
                     paddingLeft: padding,
                     paddingBottom: padding,
                     paddingRight: padding)
        
        contentView.addSubview(dismissButton)
        dismissButton.anchor(top: contentView.topAnchor,
                      right: contentView.rightAnchor,
                      paddingTop: 8,
                      paddingRight: 8,
                      width: 44,
                      height: 44)
    }
}


    //  MARK: - DetailView2Protocol
extension DetailView2Controller: DetailView2Protocol {
    func setComic(_ comic: Comic, explaination: String) {
        let titleAndNumberText = "#\(comic.num):_ \(comic.title)"
        titleAndNubmerLabel.text = titleAndNumberText
        let dateText = "\(comic.day ?? "")\(comic.month ?? "")\(comic.year ?? "")"
        dateLabel.text = dateText
        comicImageView.loadResizeAndCache(url: comic.image, targetHeight: 100)
        transcriptLabel.text = comic.transcript == "" ? "No transcript available" : comic.transcript
        explainationLabel.text = explaination
    }
}

//
//  ViewController.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: Properties
    var presenter: ComicPresenterProtocol!
    
    lazy var collectionView: UICollectionView = {
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout())
        cv.register(ComicCell.self, forCellWithReuseIdentifier: ComicCell.reuseID)
        return cv
    }()
    var navigationBar = ComicNavigationBar()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: Helpers
    
    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .gray
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        view.addSubview(navigationBar)
        navigationBar.anchor(top: collectionView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor , right: view.rightAnchor, paddingTop: 10, height: 44)
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
            let heightDimension = NSCollectionLayoutDimension.estimated(800)

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: heightDimension)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)

            return UICollectionViewCompositionalLayout(section: section)
            }
}

//MARK: ComicViewProtocol
extension MainViewController: ComicViewProtocol {
    func success() {
        collectionView.reloadData()
    }
    
    func failure(err: XkcdError) {
        print("DEBUG: error if parsing fails for a comic or its explaination \(err)")
    }
}

//MARK: CollectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCell.reuseID, for: indexPath) as! ComicCell
        let comic = presenter.comic
        cell.comic = comic
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let comic = presenter.comic else { return }
        let explaination = presenter.explaination ?? "No explaination implemented, help us to edit it"
        presenter.comicTapped(comic: comic, explaination: explaination)
    }
}

extension MainViewController: NavigationBarDelegate {
    func fetchRandomComic() {
        presenter.fetchRandomComic()
    }
    
    func fetchNextComic() {
        presenter.fetchNextComic()
    }
    
    func fetchPreviousComic() {
        presenter.fetchPreviousComic()
    }
    
    func fetchOldestComic() {
        presenter.fetchOldestComic()
    }
    
    func fetchNewestComic() {
        presenter.fetchNewestComic()
    }
}



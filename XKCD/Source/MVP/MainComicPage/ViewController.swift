//
//  ViewController.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    var presenter: ComicPresenterProtocol!
    
    lazy var collectionView: UICollectionView = {
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout())
        cv.register(ComicCell.self, forCellWithReuseIdentifier: ComicCell.reuseID)
        return cv
    }()
    var navigationBar = NavigationBar()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: Helpers
    
    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .gray
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: UIScreen.main.bounds.height * 0.8)
        collectionView.centerX(inView: view)
        view.addSubview(navigationBar)
        navigationBar.backgroundColor = .red
        navigationBar.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor , right: view.rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
            let heightDimension = NSCollectionLayoutDimension.estimated(500)

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
extension ViewController: ComicViewProtocol {
    func success() {
        collectionView.reloadData()
    }
    
    func failure(err: XkcdError) {
        print("DEBUG: error implementation required")
    }
}

//MARK: CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
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
}

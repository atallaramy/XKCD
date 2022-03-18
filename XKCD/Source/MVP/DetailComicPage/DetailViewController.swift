//
//  DetailViewController.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-17.
//

import UIKit

class DetailViewController: UIViewController {
    weak var presenter: DetailViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setComic()

    }
}

    //MARK: DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func setComic(comic: Comic?) {
        <#code#>
    }
    
    
}

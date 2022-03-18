//
//  DetailPresenter.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-17.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setComic(comic: Comic?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, comic: Comic?)
    func setComic()
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var comic: Comic?

    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, comic: Comic?) {
        self.view = view
        self.networkService = networkService
        self.comic = comic
    }
    
    func setComic() {
        self.view?.setComic(comic: comic)
        
    }
}

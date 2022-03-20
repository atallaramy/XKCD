//
//  DetailPresenter.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-17.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func success()
    func failure(err: XkcdError)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comic: Comic?, explaination: String?)
    var comic: Comic? { get set }
    var explaination: String? { get set }
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var explaination: String?
    var comic: Comic?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comic: Comic?, explaination: String?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.comic = comic
        self.explaination = explaination
    }
}

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
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, comic: Comic?, explaination: String?)
    var comic: Comic? { get set }
    var explaination: String? { get set }
}

class DetailPresenter: DetailViewPresenterProtocol {
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, comic: Comic?, explaination: String?) {
        self.view = view
        self.networkService = networkService
        self.comic = comic
        self.explaination = explaination
    }
    
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var explaination: String?
    var comic: Comic?
}

//
//  Detail2Presenter.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-09-06.
//

import Foundation

protocol DetailView2Protocol: AnyObject {
    func setComic(_ comic: Comic, explaination: String)
}

protocol DetailView2PresenterProtocol: AnyObject {
    init(view: DetailView2Protocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comic: Comic?, explaination: String?)
    var comic: Comic? { get set }
    var explaination: String? { get set }
    func setComic()
}

class Detail2Presenter: DetailView2PresenterProtocol {
    weak var view: DetailView2Protocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var explaination: String?
    var comic: Comic?
    
    required init(view: DetailView2Protocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comic: Comic?, explaination: String?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.comic = comic
        self.explaination = explaination
    }
    
    func setComic() {
        guard let comic = comic, let explaination = explaination else { return }
        view?.setComic(comic, explaination: explaination)
    }
}

//
//  ComicPresenter.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import UIKit

protocol ComicViewProtocol: AnyObject {
    func success()
    func failure(err: XkcdError)
}

protocol ComicPresenterProtocol: AnyObject {
    init(view: ComicViewProtocol, networkService: NetworkServiceProtocol)
    func fetchCurrenComic()
    func fetchComic(_ num: Int)
    var comic: Comic? { get set }
}

class ComicPresenter: ComicPresenterProtocol {
    
    var comic: Comic?
    
    weak var view: ComicViewProtocol?
    var networkService: NetworkServiceProtocol!
    var currentComicNum: Int!
    var maxComicNum: Int!
    
    required init(view: ComicViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        fetchCurrenComic()
    }
    
    public func fetchCurrenComic() {
        networkService.fetchCurrent {[weak self]result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let comic):
                    self.comic = comic
                    self.maxComicNum = comic.num
                    self.currentComicNum = comic.num
                    self.view?.success()
                case .failure(let err):
                    print("error happened", err)
                    self.view?.failure(err: err)
                }
            }
        }
    }
    
    public func fetchComic(_ num: Int) {
        networkService.fetchComid(id: num) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result{
                case .success(let comic):
                    self.comic = comic
                    self.currentComicNum = comic.num
                    self.view?.success()
                case .failure(let err):
                    self.view?.failure(err: err)
                    print("error number comic \(err)")
                }
            }
        }
    }
    
  }

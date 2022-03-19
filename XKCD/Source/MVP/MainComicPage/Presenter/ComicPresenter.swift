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
    func showAlert(title: String, message: String)
}

protocol ComicPresenterProtocol: AnyObject {
    init(view: ComicViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func fetchCurrentWithExplaination()
    func fetchComicAndExplaination(of comicNum: Int)
    func fetchRandomComic()
    func fetchNextComic()
    func fetchPreviousComic()
    func fetchOldestComic()
    func fetchNewestComic()
    func comicTapped(comic: Comic, explaination: String)
    var comic: Comic? { get set }
    var explaination:String? { get set }
   
}

class ComicPresenter: ComicPresenterProtocol {
    
    
    var comic: Comic?
    var explaination: String?
    var currentComicNum: Int!
    var maxComicNum: Int!
    
    var navigationBar = ComicNavigationBar()
    
    weak var view: ComicViewProtocol?
    var router: RouterProtocol?
    var networkService: NetworkServiceProtocol!
    
    
    required init(view: ComicViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        fetchCurrentWithExplaination()
    }
    
    func comicTapped(comic: Comic, explaination: String) {
        router?.showDetail(comic: comic, explaination: explaination)
    }
    
    public func fetchCurrentWithExplaination() {
        fetchCurrenComic {[weak self] comic in
            guard let self = self else { return }
            self.fetchExplaination(of: comic)
        }
    }
    
    public func fetchComicAndExplaination(of comicNum: Int) {
        fetchComic(comicNum) {[weak self] comic in
            guard let self = self else { return }
            self.fetchExplaination(of: comic)
        }
    }
    
    private func fetchCurrenComic(completion: @escaping (_ comic: Comic) -> Void) {
        networkService.fetchCurrent {[weak self]result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let comic):
                    completion(comic)
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
    
    private func fetchComic(_ num: Int, completion: @escaping (_ comic: Comic) -> Void) {
        networkService.fetchComic(id: num) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result{
                case .success(let comic):
                    completion(comic)
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
    
    private func fetchExplaination(of comic: Comic) {
        networkService.fetchComicExplaination(comic: comic) { result in
            switch result {
            case .success(let explaination):
                self.explaination = explaination.parse?.wikitext.explaination
                self.view?.success()
            case .failure(let err):
                self.view?.failure(err: err)
            }
        }
    }
    
    func fetchRandomComic() {
        let comicNum = Int.random(in: 1...maxComicNum)
        fetchComicAndExplaination(of: comicNum)
    }
    
    func fetchNextComic() {
        if currentComicNum == maxComicNum {
            view?.showAlert(title: Alerts.newestComic.alertTitle, message: Alerts.newestComic.alertMessage)
        } else if currentComicNum < maxComicNum {
            let comicNum = currentComicNum + 1
            fetchComicAndExplaination(of: comicNum)
        }
    }
    
    func fetchPreviousComic() {
        if currentComicNum == 1 {
            view?.showAlert(title: Alerts.oldestComic.alertTitle, message: Alerts.oldestComic.alertMessage)
        } else if currentComicNum > 1 {
            let comicNum = currentComicNum - 1
            fetchComicAndExplaination(of: comicNum)
        }
    }
    
    func fetchOldestComic() {
        if currentComicNum == 1 {
            view?.showAlert(title: Alerts.oldestComic.alertTitle, message: Alerts.oldestComic.alertMessage)
        } else {
            fetchComicAndExplaination(of: 1)
        }
    }
    
    func fetchNewestComic() {
        if currentComicNum == maxComicNum {
            view?.showAlert(title: Alerts.newestComic.alertTitle, message: Alerts.newestComic.alertMessage)
        } else {
            fetchCurrentWithExplaination()
        }
    }
    
}




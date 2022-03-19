//
//  ComicPresenterTest.swift
//  XKCDTests
//
//  Created by Ramy Atalla on 2022-03-19.
//

import XCTest
@testable import XKCD

class MockView: ComicViewProtocol {
    func success() {
    }
    
    func failure(err: XkcdError) {}
    func showAlert(title: String, message: String) {}
}

class MockNetworkService: NetworkServiceProtocol {
    var comic: Comic!
    init() {}
    
    convenience init(comic: Comic) {
        self.init()
        self.comic = comic
    }
    func fetchCurrent(completion: @escaping (Result<Comic, XkcdError>) -> Void) {
        if let comic = comic {
            completion(.success(comic))
        } else {
            let error = XkcdError(rawValue: "test")
            completion(.failure(error))
        }
    }
    
    func fetchComic(id: Int, completion: @escaping (Result<Comic, XkcdError>) -> Void) {}
    func fetchComicExplaination(comic: Comic, completion: @escaping (Result<Explaination, XkcdError>) -> Void) {}
}

class ComicPresenterTest: XCTestCase {
    
    var view: MockView!
    var presenter: ComicPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var comic: Comic!
    
    override func setUpWithError() throws {
        let nav = UINavigationController()
        let builder = AssemblyBuilder()
        router = Router(navigationController: nav, assemblyBuilder: builder)
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        networkService = nil
        router = nil
        comic = nil
    }

    func testGetSuccessComic() {
        let comic = Comic(num: 1, day: "2", month: "2", year: "2", link: "link", news: "news", safeTitle: "safeTitle", transcript: "transcript", alternativeText: "alternativeText", image: URL(string: "url")!, title: "title")
        view = MockView()
        networkService = MockNetworkService(comic: comic)
        presenter = ComicPresenter(view: view, networkService: networkService, router: router)
        
        var catchComic: Comic!
        
        networkService.fetchCurrent { result in
            switch result {
            case .success(let comic): catchComic = comic
            case .failure(let err): print(err)
            }
        }
        
        XCTAssertEqual(catchComic.news, "news")
        XCTAssertNotEqual(catchComic.safeTitle, "notSafeTitle")
    }
    
    func testGetFailureComic() {
        let comic = Comic(num: 1, day: "2", month: "2", year: "2", link: "link", news: "news", safeTitle: "safeTitle", transcript: "transcript", alternativeText: "alternativeText", image: URL(string: "url")!, title: "title")
        view = MockView()
        networkService = MockNetworkService()
        presenter = ComicPresenter(view: view, networkService: networkService, router: router)
        
        var catchError: XkcdError?
        
        networkService.fetchCurrent { result in
            switch result {
            case .success(_): break
            case .failure(let err):
                catchError = err
            }
        }
            XCTAssertNotNil(catchError)
    }

}

//
//  ComicModuleBuilder.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-17.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createComicModule(router: RouterProtocol) -> UIViewController
    func createDetialModule(comic: Comic?, explaination: String, router: RouterProtocol) -> UIViewController
    func createDetail2Module(comic: Comic?, explaination: String, router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createComicModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkManager()
        let presenter = ComicPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetialModule(comic: Comic?, explaination: String, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkManager()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, comic: comic, explaination: explaination)
        view.presenter = presenter
        return view
    }
    
    func createDetail2Module(comic: Comic?, explaination: String, router: RouterProtocol) -> UIViewController {
        let view = DetailView2Controller()
        let networkService = NetworkManager()
        let presenter = Detail2Presenter(view: view, networkService: networkService, router: router, comic: comic, explaination: explaination)
        view.presenter = presenter
        return view
    }
}

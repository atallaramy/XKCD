//
//  ComicModuleBuilder.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-17.
//

import UIKit

protocol AssemblyBuilderProtocol {
    static func createComicModule() -> UIViewController
    static func createDetialModule(comic: Comic?, explaination: String) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    static func createComicModule() -> UIViewController {
        let view = ViewController()
        let networkService = NetworkManager()
        let presenter = ComicPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createDetialModule(comic: Comic?, explaination: String) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkManager()
        let presenter = DetailPresenter(view: view, networkService: networkService, comic: comic, explaination: explaination)
        view.presenter = presenter
        return view
    }
}

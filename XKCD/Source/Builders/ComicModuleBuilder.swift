//
//  ComicModuleBuilder.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-17.
//

import UIKit

protocol Builder {
    static func createComicModule() -> UIViewController
}

class ComicModuleBuilder: Builder {
    static func createComicModule() -> UIViewController {
        let view = ViewController()
        let networkService = NetworkManager()
        let presenter = ComicPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}

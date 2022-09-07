//
//  Router.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-19.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(comic: Comic, explaination: String)
    func showDetail2(comic: Comic, explaination: String)
    func dimiss()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = true
            guard let mainViewController = assemblyBuilder?.createComicModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(comic: Comic, explaination: String) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetialModule(comic: comic, explaination: explaination, router: self) else { return }
            navigationController.present(detailViewController, animated: true, completion: nil)
        }
    }
    
    func showDetail2(comic: Comic, explaination: String) {
        if let navigationController = navigationController {
            guard let detail2ViewController = assemblyBuilder?.createDetail2Module(comic: comic, explaination: explaination, router: self) else { return }
            navigationController.present(detail2ViewController, animated: true)
        }
    }
    
    func dimiss() {
        if let navigationController = navigationController {
            navigationController.dismiss(animated: true)
        }
    }
    
}


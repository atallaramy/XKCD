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
    func showDetail(comic: Comic, explaination: Explaination)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initialViewController() {
      
        
    }
    
    func showDetail(comic: Comic, explaination: Explaination) {
        
    }
    
    func popToRoot() {
        
    }
    
        
    
}


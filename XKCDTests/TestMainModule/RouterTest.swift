//
//  RouterTest.swift
//  XKCDTests
//
//  Created by Ramy Atalla on 2022-03-19.
//

import XCTest
@testable import XKCD

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.presentedVC = viewControllerToPresent
        super.present(viewControllerToPresent, animated: true, completion: nil)
    }
}

class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    var navigationController  = MockNavigationController()
    var assemblyBuilder = AssemblyBuilder()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }

    override func tearDownWithError() throws {
        router = nil
    }
    
    func testRouter() {
        let comic = Comic(num: 1, day: "2", month: "2", year: "2", link: "link", news: "news", safeTitle: "safeTitle", transcript: "transcript", alternativeText: "alternativeText", image: URL(string: "url")!, title: "title")
        router.showDetail(comic: comic, explaination: "explaination")
        let detailViewController = navigationController.presentedVC
        XCTAssertTrue(detailViewController is DetailViewController)
    }
}

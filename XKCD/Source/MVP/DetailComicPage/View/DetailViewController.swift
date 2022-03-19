//
//  DetailViewController.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-17.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: Properties
    var presenter: DetailViewPresenterProtocol!
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.frame = view.bounds
        tv.separatorStyle = .none
        tv.frame = view.bounds
        tv.register(DetailCell.self, forCellReuseIdentifier: DetailCell.reuseID)
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureTableView()
        
    }
    
    //MARK: Helpers
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
    }
}

//MARK: DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(err: XkcdError) {
        print("DEBUG: error implementaion required.\(err)")
    }
    
}


//MARK: UITableViewDataSource
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseID, for: indexPath) as! DetailCell
        cell.comic = presenter.comic
        cell.explainationLabel.text = presenter.explaination
        return cell
    }
    
}

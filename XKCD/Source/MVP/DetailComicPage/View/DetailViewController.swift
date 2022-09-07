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
        tv.backgroundColor = .systemGray4
        tv.register(DetailCell.self, forCellReuseIdentifier: DetailCell.reuseID)
        return tv
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.addTarget(self, action: #selector(dimissView), for: .touchUpInside)
        return  button
    }()
    
    //  MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tableView.reloadData()
        configureUI()
    }
    
    //  MARK: - Selectors
    @objc func dimissView() {
        presenter.dimiss()
    }
    
    //MARK: Helpers
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
    }
    
    private func configureUI() {
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.topAnchor,
                      right: view.rightAnchor,
                      paddingTop: 8,
                      paddingRight: 8,
                      width: 44,
                      height: 44)
    }
}

    //MARK: DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    
    func success() {
        tableView.reloadData()
    }
    
    func failure(err: XkcdError) {
        print("DEBUG: error fetching Comic or Explaination, check other error message. \(err)")
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

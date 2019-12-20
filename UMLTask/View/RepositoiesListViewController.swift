//
//  RepositoriesViewController.swift
//  UMLTask
//
//  Created by Ali Kabel on 20.12.19.
//  Copyright © 2019 Ali Kabel. All rights reserved.
//

import UIKit

protocol RepositoiesListViewControllerDelegate: class {
    func repositoiesListViewController(_ viewController: RepositoiesListViewController,
                                       didSelectRepository repository: Repository)
}
final class RepositoiesListViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel: RepositoiesListViewModel
    private let networkClient: NetworkClient
    weak var delegate: RepositoiesListViewControllerDelegate?
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
        viewModel = RepositoiesListViewModel(networkClient: networkClient)
        super.init(nibName: nil, bundle: nil)
        delegate = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 64.0
        tableView.tableFooterView = UIView() // Remove empty cells at the bottom
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        showRepositories()
    }
    
    private func showRepositories() {
        viewModel.getGithubRepositories(success: {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }, failure: { error in
            print("Error: \(error)")
        })
    }
}

// MARK: - UITableViewDataSource

extension RepositoiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositoriesList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        tableViewCell.textLabel?.text = viewModel.repositoriesList[indexPath.row].fullName
        return tableViewCell
    }

}

// MARK: - UITableViewDelegate

extension RepositoiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.repositoiesListViewController(self, didSelectRepository: viewModel.repositoriesList[indexPath.row])
    }
}

// MARK: - RepositoiesListViewModelDelegate

extension RepositoiesListViewController: RepositoiesListViewModelDelegate {
    func repositoiesListViewModel(_ viewModel: RepositoiesListViewModel,
                                  didSelectRepositoryName fullName: String) {
        let repositoryDetailsViewModel = RepositoryDetailsViewModel(fullName: fullName, networkClient: networkClient)
        let repositoryDetailsViewController = RepositoryDetailsViewController(viewModel: repositoryDetailsViewModel)
        
        navigationController?.pushViewController(repositoryDetailsViewController, animated: true)
    }
}

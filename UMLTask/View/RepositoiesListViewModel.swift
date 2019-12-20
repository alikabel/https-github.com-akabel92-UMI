//
//  RepositoiesListViewModel.swift
//  UMLTask
//
//  Created by Ali Kabel on 20.12.19.
//  Copyright © 2019 Ali Kabel. All rights reserved.
//

import Foundation

protocol RepositoiesListViewModelDelegate: class {
    func repositoiesListViewModel(_ viewModel: RepositoiesListViewModel,
                                  didSelectRepositoryName name: String,
                                  owenerLoginName: String)
}

final class RepositoiesListViewModel {
    private let networkClient: NetworkClient
    var repositoriesList = [Repository]()
    weak var delegate: RepositoiesListViewModelDelegate?
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getGithubRepositories(success: (() -> Void)?, failure: ((Error) -> Void)?) {
        networkClient.performNetworkingTask(
            endPoint: GithubAPI.repositories,
            type: [Repository].self,
            success: { [weak self] repositoriesList in
                self?.repositoriesList = repositoriesList
                success?()
        },
            failure: {error in
                print("Error: \(error)")
                failure?(error)
        })
    }
}

extension RepositoiesListViewModel: RepositoiesListViewControllerDelegate {
    func repositoiesListViewController(_ viewController: RepositoiesListViewController,
                                       didSelectRepository repository: Repository) {
        delegate?.repositoiesListViewModel(self,
                                           didSelectRepositoryName: repository.fullName,
                                           owenerLoginName: repository.owner.loginName)
    }
}

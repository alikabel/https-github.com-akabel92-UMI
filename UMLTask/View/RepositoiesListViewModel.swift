//
//  RepositoiesListViewModel.swift
//  UMLTask
//
//  Created by Ali Kabel on 20.12.19.
//  Copyright © 2019 Ali Kabel. All rights reserved.
//

import Foundation

class RepositoiesListViewModel {
    private let networkClient: NetworkClient
    
    var repositoriesList = [Repository]()
    
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

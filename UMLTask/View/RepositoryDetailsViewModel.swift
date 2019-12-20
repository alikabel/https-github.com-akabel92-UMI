//
//  RepositoryDetailsViewModel.swift
//  UMLTask
//
//  Created by Ali Kabel on 20.12.19.
//  Copyright © 2019 Ali Kabel. All rights reserved.
//

import Foundation

final class RepositoryDetailsViewModel {
    let fullName: String
    let networkClient: NetworkClient
    var starsNumber = 0
    
    init(fullName: String, networkClient: NetworkClient) {
        self.fullName = fullName
        self.networkClient = networkClient
    }
    
    func getRepositoryStarsNumber(success: (() -> Void)?, failure: ((Error) -> Void)?) {
        networkClient.performNetworkingTask(
            endPoint: GithubAPI.repositoryDetails(
                repositoryFullName: fullName),
            type: RepositoryDetails.self,
            success: { [weak self] repository in
                if repository.items.count != 0 {
                    self?.starsNumber = repository.items[0].starsCount
                    success?()
                } else {
                    return
                }
            },
            failure: { error in
                failure?(error)
        })
    }
}

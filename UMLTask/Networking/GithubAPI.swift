//
//  GithubAPI.swift
//  UMLTask
//
//  Created by Ali Kabel on 19.12.19.
//  Copyright © 2019 Ali Kabel. All rights reserved.
//

import Foundation

enum GithubAPI {
    case repositories
    case repositoryDetails(ownerLoginName: String, repositoryName: String)
}

extension GithubAPI: EndpointType {
    var baseURL: URL? {
        return URL(string: Constants.baseURL)
    }
    
    var path: String {
        switch self {
        case .repositories:
            return "/repositories"
        case .repositoryDetails(let ownerLoginName, let repositoryName):
            return "/search/repositories?q=repo:\(ownerLoginName)/\(repositoryName)"
        }
    }
}

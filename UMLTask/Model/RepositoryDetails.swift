//
//  RepositoryItems.swift
//  UMLTask
//
//  Created by Ali Kabel on 19.12.19.
//  Copyright © 2019 Ali Kabel. All rights reserved.
//

import Foundation

struct RepositoryDetails: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let starsCount: Int
        
        enum CodingKeys: String, CodingKey {
            case starsCount = "stargazers_count"
        }
    }
}

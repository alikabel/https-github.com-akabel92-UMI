//
//  Repository.swift
//  UMLTask
//
//  Created by Ali Kabel on 19.12.19.
//  Copyright © 2019 Ali Kabel. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let fullName: String
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case owner = "owner"
    }
    
    struct Owner: Codable {
        let loginName: String
        
        enum CodingKeys: String, CodingKey {
            case loginName = "login"
        }
    }
}

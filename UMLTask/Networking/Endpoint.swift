//
//  Endpoint.swift
//  UMLTask
//
//  Created by Ali Kabel on 19.12.19.
//  Copyright © 2019 Ali Kabel. All rights reserved.
//

import Foundation

protocol EndpointType {
    var baseURL: URL? { get }
    var path: String { get }
}

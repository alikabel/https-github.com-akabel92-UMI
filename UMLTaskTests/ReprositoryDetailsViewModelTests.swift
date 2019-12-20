//
//  ReprositoryDetailsViewModelTests.swift
//  UMLTaskTests
//
//  Created by Ali Kabel on 20.12.19.
//  Copyright © 2019 Ali Kabel. All rights reserved.
//

import XCTest
@testable import UMLTask

class ReprositoryDetailsViewModelTests: XCTestCase {
    func testGetRepositoryStarsNumberWithRepositoryItems() {
        let items = [RepositoryDetails.Item(starsCount: 5)]
        let repoDetails = RepositoryDetails(items: items)
        
        XCTAssert(repoDetails.items[0].starsCount == 5)
    }
    
    func testGetRepositoryWithEmptyRepositoryItems() {
        let items = [RepositoryDetails.Item]()
        let repoDetails = RepositoryDetails(items: items)
        
        XCTAssert(repoDetails.items.isEmpty)
    }
}

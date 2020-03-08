//
//  StarWarsServiceTests.swift
//  StarWarsProjectTests
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import XCTest
@testable import StarWarsProject

class StarWarsServiceTests: XCTestCase {
    func testStarWarsServiceCall() {
        // Given
        let responseExpectation = expectation(description: "Star wars service should retrieve a result")
        let sut = StarWarsService()
        
        // When
        sut.fetchCaracterList(page: 1, searchQuery: nil) { cenas in
            responseExpectation.fulfill()
        }
        
        // Then
        wait(for: [responseExpectation], timeout: 3)
    }
}

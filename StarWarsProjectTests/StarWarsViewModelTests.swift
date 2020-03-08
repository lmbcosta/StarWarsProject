//
//  StarWarsViewModelTests.swift
//  StarWarsProjectTests
//
//  Created by Luis  Costa on 08/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import XCTest
@testable import StarWarsProject

class StarWarsViewModelTests: XCTestCase {
    private let bundle = Bundle(for: StarWarsViewModelTests.self)
    
    func testViewModelRetrievingItems() {
        // Given
        let jsonFileName = "StarWarsResponseFirstPage"
        let response: StarWarsResponse = bundle.decodeFile(name: jsonFileName)!
        let mockService = MockStarWarsService(expectedResult: .success(response))
        let itemsExpectation = expectation(description: "ViewModel should retrieve view state .data(items:)")
        let sut = StarWarsViewModel(service: mockService)
        
        // When
        sut.fetchNextPaginatedItems {
            if case .data = $0 {
                itemsExpectation.fulfill()
            }
        }
        
        // Then
        wait(for: [itemsExpectation], timeout: 0.3)
    }
    
    func testViewModelRetrievingEmptyItems() {
        // Given
        let jsonFileName = "StarWarsEmptyResponse"
        let response: StarWarsResponse = bundle.decodeFile(name: jsonFileName)!
        let mockService = MockStarWarsService(expectedResult: .success(response))
        let emptyItemsExpectation = expectation(description: "ViewModel should retrieve view state .error(title:message:)")
        let sut = StarWarsViewModel(service: mockService)
        
        // When
        sut.fetchNextPaginatedItems {
            if case .noResults = $0 {
                emptyItemsExpectation.fulfill()
            }
        }
        
        // Then
        wait(for: [emptyItemsExpectation], timeout: 0.3)
    }
    
    func testViewModelRetrievingError() {
        // Given
        let error = AppError.noResults
        let mockService = MockStarWarsService(expectedResult: .failure(error))
        let errorExpectation = expectation(description: "ViewModel should retrieve view state .error(title:message:)")
        let sut = StarWarsViewModel(service: mockService)
        
        // When
        sut.fetchNextPaginatedItems(then: {
            if case .error = $0 {
                errorExpectation.fulfill()
            }
        })
        
        // Then
        wait(for: [errorExpectation], timeout: 0.3)
    }
    
    func testStarWarsViewModelWithMoreItems() {
        // Given
        let jsonFileName = "StarWarsResponseFirstPage"
        let response: StarWarsResponse = bundle.decodeFile(name: jsonFileName)!
        let mockService = MockStarWarsService(expectedResult: .success(response))
        let sut = StarWarsViewModel(service: mockService)
        
        // When
        sut.fetchNextPaginatedItems(then: { _ in })
        
        // Then
        XCTAssertTrue(sut.hasMore)
    }
    
    func testStarWarsViewModelWithoutMoreItems() {
        // Given
        let jsonFileName = "StarWarsResponseLastPage"
        let response: StarWarsResponse = bundle.decodeFile(name: jsonFileName)!
        let mockService = MockStarWarsService(expectedResult: .success(response))
        let sut = StarWarsViewModel(service: mockService)
        
        // When
        sut.fetchNextPaginatedItems(then: { _ in })
        
        // Then
        XCTAssertFalse(sut.hasMore)
    }
}

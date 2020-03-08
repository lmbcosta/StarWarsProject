//
//  ResponseModelTests.swift
//  StarWarsProjectTests
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import XCTest
@testable import StarWarsProject

class ResponseModelTests: XCTestCase {
    private let bundle = Bundle(for: ResponseModelTests.self)
    
    func testCharacterResponse() {
        // Given
        let jsonFileName = "Character"
        
        // When
        let sut: StarWarsCharacter = bundle.decodeFile(name: jsonFileName)!
        
        // Then
        XCTAssertTrue(sut.name == "Luke Skywalker")
    }
    
    func testCharacterWithoutName() {
        // Given
        let jsonFileName = "CharacterWithoutName"
        
        // Then
        let sut: StarWarsCharacter = bundle.decodeFile(name: jsonFileName)!
        
        // When
        XCTAssert(sut.name == StarWarsCharacter.namePlaceholder)
    }
    
    func testStarWarsResponseFirstPage() {
        // Given
        let jsonFileName = "StarWarsResponseFirstPage"

        // Then
        let sut: StarWarsResponse = bundle.decodeFile(name: jsonFileName)!

        // When
        XCTAssertTrue(sut.count == 87)
        XCTAssertTrue(sut.results.count == 10)
        XCTAssertNotNil(sut.next)
        XCTAssertNil(sut.previous)
    }
    
    func testStarWarsResponseLastPage() {
        // Given
        let jsonFileName = "StarWarsResponseLastPage"

        // Then
        let sut: StarWarsResponse = bundle.decodeFile(name: jsonFileName)!

        // When
        XCTAssertTrue(sut.count == 87)
        XCTAssertTrue(sut.results.count == 7)
        XCTAssertNotNil(sut.previous)
        XCTAssertNil(sut.next)
    }
}

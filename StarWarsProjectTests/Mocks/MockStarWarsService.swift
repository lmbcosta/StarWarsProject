//
//  StarWarsServiceMock.swift
//  StarWarsProjectTests
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

@testable import StarWarsProject

struct MockStarWarsService: StarWarsServiceProtocol {
    let expectedResult: Result<StarWarsResponse, Error>
    
    init(expectedResult: Result<StarWarsResponse, Error>) {
        self.expectedResult = expectedResult
    }
    
    func fetchCaracterList(page: Int, searchQuery: String?, then handler: @escaping (Result<StarWarsResponse, Error>) -> Void) {
        handler(expectedResult)
    }
}

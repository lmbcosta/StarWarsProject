//
//  StarWarsResponse.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

struct StarWarsResponse: Decodable {
    // MARK: - Properties
    let count: Int
    let next: String?
    let previous: String?
    let results: [StarWarsCharacter]
    
    // MARK: - Helpers
    var hasResults: Bool { !results.isEmpty }
}

struct StarWarsCharacter: Decodable {
    // MARK: - Properties
    static let namePlaceholder = "Unknown"
    let name: String
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = (try? container.decode(String.self, forKey: .name)) ?? StarWarsCharacter.namePlaceholder
    }
}

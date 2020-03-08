//
//  ViewState.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

enum ViewState {
    case data(items: [StarWarsCharacter])
    case error(title: String, message: String)
    case noResults(title: String, message: String)
}

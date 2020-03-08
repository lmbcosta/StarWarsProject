//
//  StarWarsSearchDelegate.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 08/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

class StarWarsSearchBarDelegate: NSObject, UISearchBarDelegate {
    // MARK: - Properties
    var searchHandler: ((ViewState) -> Void)?
    
    private let viewModel: StarWarsViewModelSearchableProtocol
    
    // MARK: - Initializer
    init(viewModel: StarWarsViewModelSearchableProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Internal
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let query = searchBar.getCurrentText(for: range, input: text)
        viewModel.fetchSearchedItems(matching: query) { [weak self] in
            self?.searchHandler?($0)
        }
        
        return true
    }
}

//
//  StarWarsViewModel.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import Foundation

protocol StarWarsViewModelSearchableProtocol {
    func fetchSearchedItems(matching query: String?, then handler: @escaping (ViewState) -> Void)
}

protocol StarWarsViewModelPaginableProtocol {
    func fetchNextPaginatedItems(then handler: @escaping (ViewState) -> Void)
}

protocol StarWarsViewModelReloadableProtocol {
    var hasMore: Bool { get }
}

protocol StarWarsViewModelProtocol {
    var viewModelSearchableProtocol: StarWarsViewModelSearchableProtocol { get }
    var viewModelPaginableProtocol: StarWarsViewModelPaginableProtocol { get }
    var viewModelReloadableProtocol: StarWarsViewModelReloadableProtocol { get }
}

class StarWarsViewModel: StarWarsViewModelProtocol {
    // MARK: Properties
    var viewModelReloadableProtocol: StarWarsViewModelReloadableProtocol { self }
    var viewModelSearchableProtocol: StarWarsViewModelSearchableProtocol { self }
    var viewModelPaginableProtocol: StarWarsViewModelPaginableProtocol { self }
    
    private let service: StarWarsServiceProtocol
    
    private var hasMoreItems: Bool = true
    private var currentPage: Int
    private var queryText: String?
    
    // MARK:  Initializer
    init(service: StarWarsServiceProtocol) {
        self.service = service
        self.currentPage = 1
    }
    
    // MARK: - Private
    private func fetchItems(page: Int = 1,
                            query: String? = nil,
                            then handler: @escaping (ViewState) -> Void) {
        service.fetchCaracterList(page: page, searchQuery: query) { [weak self] result in
            switch result {
            case .success(let response):
                self?.setPaginationState(hasNext: response.next != nil)
                let viewState: ViewState = response.hasResults ?
                    .data(items: response.results) :
                    .noResults(title: Strings.noResultsTitle, message: Strings.noResultsMessage)
                
                if !response.hasResults {
                    self?.resetPaginationState()
                }
                
                DispatchQueue.main.async {
                    handler(viewState)
                }
                
            case .failure:
                self?.resetPaginationState()
                
                DispatchQueue.main.async {
                    handler(.error(title: Strings.errorTitle, message: Strings.errorMessage))
                }
            }
        }
    }
    
    private func setPaginationState(hasNext: Bool) {
        hasMoreItems = hasNext
        updateCurrentPage(value: hasNext ? 1 : 0)
    }
    
    private func resetPaginationState() {
        hasMoreItems = true
        updateCurrentPage(value: 1)
    }
    
    private func updateCurrentPage(value: Int) {
        currentPage = value
    }
}

// MARK: - StarWarsViewModelSearchableProtocol
extension StarWarsViewModel: StarWarsViewModelSearchableProtocol {
    func fetchSearchedItems(matching query: String?, then handler: @escaping (ViewState) -> Void) {
        queryText = query
        resetPaginationState()
        fetchItems(query: query, then: handler)
    }
}

// MARK: - StarWarsViewModelPaginableProtocol
extension StarWarsViewModel: StarWarsViewModelPaginableProtocol {
    func fetchNextPaginatedItems(then handler: @escaping (ViewState) -> Void) {
        queryText = nil
        fetchItems(page: currentPage, then: handler)
    }
}

// MARK: - StarWarsViewModelReloadableProtocol
extension StarWarsViewModel: StarWarsViewModelReloadableProtocol {
    var hasMore: Bool { hasMoreItems }
}

extension StarWarsViewModel {
    struct Strings {
        static let errorTitle = "Error"
        static let errorMessage = "Something went wrong. Please try again!"
        static let noResultsTitle = "Oops..."
        static let noResultsMessage = "Search without any result"
    }
}

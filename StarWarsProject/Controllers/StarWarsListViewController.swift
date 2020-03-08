//
//  CharacterListViewController.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

class StarWarsListViewController: UIViewController {
    // MARK: - Properties
    private let searchController: UISearchController
    private let dataSource: StarWarsListDataSourceProtocol
    private let searchBarDelegate: StarWarsSearchBarDelegate
    private let tableView = UITableView()
    private let emptyStateView = EmptyStateView()
    private let viewModel: StarWarsViewModelPaginableProtocol
    
    // MARK: - Initializers
    init(viewModel: StarWarsViewModelProtocol,
         searchController: UISearchController) {
        self.searchController = searchController
        self.viewModel = viewModel.viewModelPaginableProtocol
        self.dataSource = StarWarsListDataSource(tableView: tableView,
                                                  viewModel: viewModel.viewModelReloadableProtocol)
        self.searchBarDelegate = StarWarsSearchBarDelegate(viewModel: viewModel.viewModelSearchableProtocol)
        super.init(nibName: nil, bundle: nil)
        
        searchBarDelegate.searchHandler = { [weak self] in
            self?.handleViewState($0, shouldReplaceItems: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        triggerRequest()
    }
    
    // MARK: - Private
    private func setupLayout() {
        title = Strings.title
        setupSearchController()
        setupTableView()
        setupEmptyStateView()
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = Strings.SearchBar.placeholder
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        tableView.rowHeight = Dimensions.TableView.cellHeight
        tableView.delegate = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupEmptyStateView() {
        emptyStateView.isHidden = true
        view.addSubview(emptyStateView)
        view.bringSubviewToFront(emptyStateView)
        setupEmptyStateViewConstraints()
    }
    
    private func setupEmptyStateViewConstraints() {
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func fetchPaginatedItems(shouldReplaceItems: Bool) {
        viewModel.fetchNextPaginatedItems(then: { [weak self] in
            self?.handleViewState($0, shouldReplaceItems: shouldReplaceItems)
        })
    }
    
    private func triggerRequest() {
        dataSource.setItems([], then: nil)
        fetchPaginatedItems(shouldReplaceItems: true)
    }
    
    private func reloadData(newItems: [StarWarsCharacter], shouldReplaceItems: Bool) {
        let handler: () -> Void = { [weak self] in
            self?.tableView.reloadData()
        }
        
        if shouldReplaceItems {
            dataSource.setItems(newItems, then: handler)
        }
        else {
            dataSource.addItems(newItems, then: handler)
        }
        
        emptyStateView.isHidden = true
    }
    
    private func handleViewState(_ viewState: ViewState, shouldReplaceItems: Bool) {
        switch viewState {
        case .data(items: let items):
            reloadData(newItems: items, shouldReplaceItems: shouldReplaceItems)
            
        case .error(title: let title, message: let message):
            handleEmptyState(title: title, message: message, showButton: true)
            
        case .noResults(title: let title, message: let message):
            handleEmptyState(title: title, message: message, showButton: false)
        }
    }
    
    private func handleEmptyState(title: String, message: String, showButton: Bool) {
        emptyStateView.configure(title: title,
                                 message: message,
                                 showButtom: showButton,
                                 buttonHandle: { [weak self] in
                                    self?.triggerRequest()
                                    self?.emptyStateView.isHidden = true })
        
        emptyStateView.isHidden = false
    }
}

// MARK: - UITableViewDelegate
extension StarWarsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if dataSource.isLoadingCell(cell: cell) {
            self.fetchPaginatedItems(shouldReplaceItems: false)
        }
    }
}

// MARK: - UISearchResultsUpdating
extension StarWarsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.delegate = searchBarDelegate
    }
}

// MARK: - Constants
private extension StarWarsListViewController {
    struct Strings {
        static let title = "Star Wars"
        
        struct SearchBar {
            static let placeholder = "Search your favorite characters"
        }
    }
    
    struct Dimensions {
        struct TableView {
            static let cellHeight:  CGFloat = 50
        }
    }
}


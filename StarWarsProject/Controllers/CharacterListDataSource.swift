//
//  CharacterListDataSource.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

protocol StarWarsListDataSourceProtocol {
    func addItems(_ newItems: [StarWarsCharacter], then handler: () -> Void)
    func setItems(_ newItems: [StarWarsCharacter], then handler: (() -> Void)?)
    func isLoadingCell(cell: UITableViewCell) -> Bool
}

final class CharacterListDataSource: NSObject, StarWarsListDataSourceProtocol {
    // MARK: - Properties:
    let tableView: UITableView
    let viewModel: StarWarsViewModelReloadableProtocol
    
    var items: [StarWarsCharacter]
    
    
    // MARK: - Initializer
    init(tableView: UITableView,
         viewModel: StarWarsViewModelReloadableProtocol) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.items = []
        
        super.init()
        configureTableView()
    }
    
    // MARK: - Internal
    func addItems(_ newItems: [StarWarsCharacter],
                     then handler: () -> Void) {
        items.append(contentsOf: newItems)
        handler()
    }
    
    func setItems(_ newItems: [StarWarsCharacter],
                  then handler: (() -> Void)?) {
        items = newItems
        handler?()
    }
    
    func isLoadingCell(cell: UITableViewCell) -> Bool {
        return cell is LoadingCell
    }
    
    // MARK: - Private
    func configureTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.reuseIdentifier)
    }
    
    private func buildLoadingCell(for indexPath: IndexPath) -> LoadingCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.reuseIdentifier, for: indexPath) as? LoadingCell else {
            fatalError("👻 Unable to dequeue cell with identifier: \(LoadingCell.reuseIdentifier)")
        }
        
        cell.startAnimating()
        return cell
    }
    
    private func buildTextCell(for indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = item.name
        return cell
    }
}

// MARK; - UITableviewDataSource
extension CharacterListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfItems = items.count
        return viewModel.hasMore ? numberOfItems + 1 : numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isLoadingCell = indexPath.item == items.count
        
        return isLoadingCell ? buildLoadingCell(for: indexPath) : buildTextCell(for: indexPath)
    }
}

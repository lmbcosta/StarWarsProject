//
//  AppCoordinator.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

final class AppCoordinator {
    // MARK: - Properites
    static let shared: AppCoordinator = AppCoordinator()
    
    // MARK: - Initializer
    private init() {}
    
    // MARK: - Internal
    func buildRootViewController() -> UIViewController {
        let service = StarWarsService()
        let viewModel = StarWarsViewModel(service: service)
        let searController = buildSearController()
        let viewController = StarWarsListViewController(viewModel: viewModel,
                                                        searchController: searController)
        return StarWarsNavigationController(rootViewController: viewController)
    }
    
    // MARK: Private
    func buildSearController() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }
}

//
//  StarWarsService.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import Foundation

protocol StarWarsServiceProtocol {
    func fetchCaracterList(page: Int,
                           searchQuery: String?,
                           then handler: @escaping (Result<StarWarsResponse, Error>) -> Void)
}

class StarWarsService: StarWarsServiceProtocol {
    // MARK: - Properties
    private var currentTask: URLSessionTask?
    
    // MARK: - Internal
    func fetchCaracterList(page: Int,
                           searchQuery: String?,
                           then handler: @escaping (Result<StarWarsResponse, Error>) -> Void) {
        guard let url = buildURL(for: page, search: searchQuery) else {
            handler(.failure(AppError.requestError))
            return
        }
        
        if let currentTask = currentTask, currentTask.state == .running {
            currentTask.cancel()
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            // Handle Error
            if let error = error {
                // Check for current task cancelation error
                guard (error as NSError).code != Errors.Code.canceled else {
                    return
                }
                
                handler(.failure(error))
                return
            }
            
            guard let data = data else {
                handler(.failure(AppError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(StarWarsResponse.self, from: data)
                handler(.success(response))
            } catch let error {
                handler(.failure(error))
                return
            }
        }
        
        currentTask = task
        task.resume()
    }
    
    // MARK: - Private
    private func buildURL(for page: Int,
                  search: String?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path
        
        let pageQueryItem = URLQueryItem(name: Constants.pageKeyParameter,
                                         value: "\(page)")
        var queryItems: [URLQueryItem] = [pageQueryItem]
        
        if let search = search, !search.isEmpty {
            queryItems.append(URLQueryItem(name: Constants.searchKeyParameter,
                                           value: search))
        }
        
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}

private extension StarWarsService {
    struct Constants {
        static let host = "swapi.co"
        static let path = "/api/people"
        static let get = "GET"
        static let pageKeyParameter = "page"
        static let searchKeyParameter = "search"
        static let scheme = "https"
    }
    
    struct Errors {
        struct Code {
            static let canceled = -999
        }
    }
}


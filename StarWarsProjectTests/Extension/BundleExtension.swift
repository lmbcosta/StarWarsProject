//
//  BundleExtension.swift
//  StarWarsProjectTests
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import Foundation

extension Bundle {
    func decodeFile<T: Decodable>(name: String, extenson: String = "json") -> T? {
        guard let fileURL = url(forResource: name, withExtension: extenson) else {
            assertionFailure("👻: Could not find file with name: \(name).\(extenson) in bundle")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let modelObject = try JSONDecoder().decode(T.self, from: data)
            return modelObject
        } catch let error {
            assertionFailure("👻: Failed decoding resource: \(name).\(extenson): \(error.localizedDescription)")
            return nil
        }
    }
}

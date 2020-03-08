//
//  UISearchBarExtension.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 08/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

extension UISearchBar {
    func getCurrentText(for range: NSRange, input: String) -> String {
        guard let text = text else { return "" }
        
        guard range.length == 1 else {
            return text + input
        }
        
        return String(text.dropLast())
    }
}

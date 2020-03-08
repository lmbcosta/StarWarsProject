//
//  LoadingCell.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "LoadingCell"
    private let activityIndicator: UIActivityIndicatorView
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        activityIndicator = UIActivityIndicatorView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Internal
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    // MARK: - Private
    private func setupActivityIndicator() {
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        contentView.addSubview(activityIndicator)
        setupActivityIndicatorConstraints()
    }
    
    private func setupActivityIndicatorConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: Constants.activityIndicatorSide),
            activityIndicator.widthAnchor.constraint(equalToConstant: Constants.activityIndicatorSide)
        ])
    }
}

private extension LoadingCell {
    struct Constants {
        static let activityIndicatorSide: CGFloat = 40
    }
}

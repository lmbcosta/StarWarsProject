//
//  EmptyStateView.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    // MARK: - Properties
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let stackView = UIStackView()
    let button = UIButton()
    
    var buttonHandle: (() -> Void)?
    
    // MARK:  Initializer
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    override func layoutSubviews() {
        super.layoutSubviews()
        button.layer.cornerRadius = button.frame.height / 2
    }
    
    // MARK: - Internal
    func configure(title: String,
                   message: String,
                   showButtom: Bool,
                   buttonHandle: (() -> Void)?) {
        titleLabel.text = title
        descriptionLabel.text = message
        button.isHidden = !showButtom
        self.buttonHandle = buttonHandle
    
        layoutIfNeeded()
    }
    
    // MARK: - Private
    private func setupLayout() {
        backgroundColor = .white
        setupTitleLabel()
        setupDescriptionLabel()
        setupButton()
        setupStackView()
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .black
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupButton() {
        button.setTitle(Strings.Button.title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.contentEdgeInsets = Dimensions.Button.contentEdgeInset
        stackView.addArrangedSubview(button)
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = Dimensions.StackView.spacing
        addSubview(stackView)
        setupStackViewConstraints()
    }
    
    private func setupStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    @objc private func buttonTapped() { buttonHandle?() }
}

private extension EmptyStateView {
    struct Strings {
        struct Button {
            static let title = "Reload"
        }
    }
    
    struct Dimensions {
        struct Button {
            static let contentEdgeInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        }
        
        struct StackView {
            static let spacing: CGFloat = 20
        }
    }
}

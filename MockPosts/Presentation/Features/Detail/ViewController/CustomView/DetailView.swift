//
//  DetailView.swift
//  MockPosts
//
//  Created by Ruyther Costa on 2023-11-03.
//

import UIKit

final class DetailView: UIView {

    // MARK: - Internal Properties

    let activityIndicator = UIActivityIndicatorView(style: .large).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let titleLabel = UILabel(translateMask: false).apply {
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.textAlignment = .center
        $0.tintColor = .black
        $0.numberOfLines = 0
    }

    let descriptionLabel = UILabel(translateMask: false).apply {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.textAlignment = .left
        $0.tintColor = .black
        $0.numberOfLines = 0
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCode Extension

extension DetailView: ViewCode {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(activityIndicator)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

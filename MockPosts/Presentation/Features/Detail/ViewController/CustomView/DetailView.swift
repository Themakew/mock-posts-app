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

    let tableViewTitleLabel = UILabel(translateMask: false).apply {
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.textAlignment = .center
    }

    let tableView = UITableView(translateMask: false).apply {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 50
    }

    // MARK: - Private Properties

    private let stackView = UIStackView(translateMask: false).apply {
        $0.spacing = 4
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
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

    // MARK: - Internal Methods

    func setupFixedTitle(with numberOfComments: Int) {
        let titleText = "Comments (\(numberOfComments))"
        tableViewTitleLabel.text = titleText
    }
}

// MARK: - ViewCode Extension

extension DetailView: ViewCode {
    func buildViewHierarchy() {
        addSubview(stackView)
        addSubview(tableView)
        addSubview(tableViewTitleLabel)
        addSubview(activityIndicator)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor),

            tableViewTitleLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            tableViewTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableViewTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: tableViewTitleLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

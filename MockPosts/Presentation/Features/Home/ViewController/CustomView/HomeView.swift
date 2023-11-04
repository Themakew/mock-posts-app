//
//  HomeView.swift
//  MockPosts
//
//  Created by Ruyther Costa on 30/01/23.
//

import UIKit

final class HomeView: UIView {

    // MARK: - Internal Properties

    let refreshControl = UIRefreshControl()
    let tableView = UITableView(translateMask: false).apply {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 50
    }

    let activityIndicator = UIActivityIndicatorView(style: .large).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
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

extension HomeView: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(activityIndicator)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white

        tableView.refreshControl = refreshControl
    }
}

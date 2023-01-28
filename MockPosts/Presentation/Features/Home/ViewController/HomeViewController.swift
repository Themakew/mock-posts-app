//
//  HomeViewController.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Private Properties

    private let viewModel: HomeViewModelProtocol

    // MARK: - Initializers

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        viewModel.input.getPosts.accept(())
    }
}

// MARK: - ViewCode Extension

extension HomeViewController: ViewCode {
    func buildViewHierarchy() {

    }

    func setupConstraints() {

    }

    func setupAdditionalConfiguration() {
        view.backgroundColor = .red
    }
}

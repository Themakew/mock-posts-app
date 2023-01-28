//
//  HomeCoordinator.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import XCoordinator
import UIKit

enum HomeRouter: Route {
    case home
    case dismiss
}

final class HomeCoordinator: NavigationCoordinator<HomeRouter> {

    // MARK: - Initializer

    init() {
        super.init(initialRoute: .home)
    }

    // MARK: - Override Method

    override func prepareTransition(for route: HomeRouter) -> NavigationTransition {
        switch route {
        case .home:
            let viewModel = HomeViewModel()
            let viewController = HomeViewController(viewModel: viewModel)
            return .push(viewController)
        case .dismiss:
            return .dismiss()
        }
    }
}

//
//  AppCoordinator.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import XCoordinator

enum AppRouter: Route {
    case start
}

final class AppCoordinator: NavigationCoordinator<AppRouter> {

    // MARK: - Initializer

    init() {
        super.init(initialRoute: .start)
    }

    // MARK: - Override Method

    override func prepareTransition(for route: AppRouter) -> NavigationTransition {
        switch route {
        case .start:
            let coordinator = HomeCoordinator()
            coordinator.viewController.modalPresentationStyle = .fullScreen
            return .presentOnRoot(coordinator, animation: nil)
        }
    }
}

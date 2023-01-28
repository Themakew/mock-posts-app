//
//  HomeCoordinator.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import UIKit
import XCoordinator

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
            let service = ServiceAPICall()
            let postService = PostAPIService(serviceAPI: service)
            let postRepository = PostRepository(postAPIService: postService)
            let postUseCase = PostUseCase(postRepository: postRepository)
            let viewModel = HomeViewModel(router: weakRouter, postUseCase: postUseCase)
            let viewController = HomeViewController(viewModel: viewModel)
            return .push(viewController)
        case .dismiss:
            return .dismiss()
        }
    }
}

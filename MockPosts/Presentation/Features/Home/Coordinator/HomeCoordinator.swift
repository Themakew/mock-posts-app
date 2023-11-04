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
    case detail(String)
}

final class HomeCoordinator: NavigationCoordinator<HomeRouter> {

    // MARK: - Private Properties

    private lazy var service = ServiceAPICall()
    private lazy var postService = PostAPIService(serviceAPI: service)
    private lazy var postRepository = PostRepository(postAPIService: postService)
    private lazy var postUseCase = PostUseCase(postRepository: postRepository)

    // MARK: - Initializer

    init() {
        super.init(initialRoute: .home)
    }

    // MARK: - Override Method

    override func prepareTransition(for route: HomeRouter) -> NavigationTransition {
        switch route {
        case .home:
            let viewModel = HomeViewModel(router: weakRouter, postUseCase: postUseCase)
            let viewController = HomeViewController(viewModel: viewModel)
            return .push(viewController)
        case let .detail(postId):
            let viewModel = DetailViewModel(
                router: weakRouter,
                postUseCase: postUseCase,
                postId: postId
            )
            let viewController = DetailViewController(viewModel: viewModel)
            return .push(viewController)
        case .dismiss:
            return .dismiss()
        }
    }
}

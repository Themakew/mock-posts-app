//
//  PostUseCase.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import RxSwift

final class PostUseCase: PostUseCaseProtocol {

    // MARK: - Private Property

    private let postRepository: PostRepositoryProtocol

    // MARK: - Initializer

    init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }

    // MARK: - Internal Methods

    func getPosts() -> Single<Result<[PostEntity], NetworkError>> {
        return postRepository.getPosts()
    }

    func getPostDetail(postId: String) -> Single<Result<PostEntity, NetworkError>> {
        return postRepository.getPostDetail(postId: postId)
    }

    func getPostDetailComments(postId: String) -> Single<Result<[PostCommentsEntity], NetworkError>> {
        return postRepository.getPostDetailComments(postId: postId)
    }

    func getPostIcon(postId: String) -> RxSwift.Single<Result<PhotoEntity, NetworkError>> {
        return postRepository.getPostIcon(postId: postId)
    }
}

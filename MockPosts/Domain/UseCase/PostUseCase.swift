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

    func getPosts() -> Single<Result<[PostResponse], NetworkError>> {
        return postRepository.getPosts()
    }

    func getPostDetail(postId: String) -> Single<Result<PostResponse, NetworkError>> {
        return postRepository.getPostDetail(postId: postId)
    }

    func getPostDetailComments(postId: String) -> Single<Result<[PostCommentsResponse], NetworkError>> {
        return postRepository.getPostDetailComments(postId: postId)
    }
}

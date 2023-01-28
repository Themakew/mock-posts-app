//
//  PostRepository.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import RxSwift

final class PostRepository: PostRepositoryProtocol {

    // MARK: - Private Property

    private let postAPIService: PostAPIServiceProtocol

    // MARK: - Initializer

    init(postAPIService: PostAPIServiceProtocol) {
        self.postAPIService = postAPIService
    }

    // MARK: - Internal Methods

    func getPosts() -> Single<Result<[PostResponse], NetworkError>> {
        return postAPIService.getPosts()
    }

    func getPostDetail(postId: String) -> Single<Result<PostResponse, NetworkError>> {
        return postAPIService.getPostDetail(postId: postId)
    }

    func getPostDetailComments(postId: String) -> Single<Result<[PostCommentsResponse], NetworkError>> {
        return postAPIService.getPostDetailComments(postId: postId)
    }
}

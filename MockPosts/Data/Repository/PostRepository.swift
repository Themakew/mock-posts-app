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

    func getPosts() -> Single<Result<[PostEntity], NetworkError>> {
        return postAPIService.getPosts()
            .map { [weak self] result in
                guard let self else {
                    return .failure(NetworkError.genericError(error: "[PostResponse] map to [PostEntity] failed."))
                }

                switch result {
                case let .success(list):
                    return .success(self.getPostEntityList(list: list))
                case let .failure(error):
                    return .failure(error)
                }
            }
    }

    func getPostDetail(postId: String) -> Single<Result<PostEntity, NetworkError>> {
        return postAPIService.getPostDetail(postId: postId)
            .map { [weak self] result in
                guard let self else {
                    return .failure(NetworkError.genericError(error: "PostResponse map to PostEntity failed."))
                }

                switch result {
                case let .success(object):
                    return .success(self.getPostEntity(object: object))
                case let .failure(error):
                    return .failure(error)
                }
            }
    }

    func getPostDetailComments(postId: String) -> Single<Result<[PostCommentsEntity], NetworkError>> {
        return postAPIService.getPostDetailComments(postId: postId)
            .map { [weak self] result in
                guard let self else {
                    return .failure(
                        NetworkError.genericError(error: "[PostCommentsResponse] map to [PostCommentsEntity] failed.")
                    )
                }

                switch result {
                case let .success(list):
                    return .success(self.getPostCommentsEntityList(list: list))
                case let .failure(error):
                    return .failure(error)
                }
            }
    }

    func getPostIcon(postId: String) -> Single<Result<PhotoEntity, NetworkError>> {
        return postAPIService.getPhoto(postId: postId)
            .map { [weak self] result in
                guard let self else {
                    return .failure(
                        NetworkError.genericError(error: "[PhotoResponse] map to [PhotoEntity] failed.")
                    )
                }

                switch result {
                case let .success(list):
                    return .success(self.getPhotoEntity(object: list))
                case let .failure(error):
                    return .failure(error)
                }
            }
    }

    // MARK: - Private Methods

    private func getPostEntityList(list: [PostResponse]) -> [PostEntity] {
        let auxiliarList = list
        return auxiliarList.map { item in
            PostEntity(userId: item.userId, id: item.id, title: item.title, body: item.body, iconURL: "", isFavorite: false)
        }
    }

    private func getPostEntity(object: PostResponse) -> PostEntity {
        return PostEntity(
            userId: object.userId,
            id: object.id,
            title: object.title,
            body: object.body,
            iconURL: "",
            isFavorite: false
        )
    }

    private func getPostCommentsEntityList(list: [PostCommentsResponse]) -> [PostCommentsEntity] {
        let auxiliarList = list
        return auxiliarList.map { item in
            PostCommentsEntity(postId: item.postId, id: item.id, name: item.name, email: item.email, comment: item.body)
        }
    }

    private func getPhotoEntity(object: PhotoResponse) -> PhotoEntity {
        return PhotoEntity(iconURL: object.thumbnailUrl, imageURL: object.url)
    }
}

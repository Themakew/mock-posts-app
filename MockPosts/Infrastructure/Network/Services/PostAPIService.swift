//
//  PostAPIService.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import Alamofire
import RxSwift

protocol PostAPIServiceProtocol {
    func getPosts() -> Single<Result<[PostResponse], NetworkError>>
    func getPostDetail(postId: String) -> Single<Result<PostResponse, NetworkError>>
    func getPostDetailComments(postId: String) -> Single<Result<[PostCommentsResponse], NetworkError>>
    func getPhoto(postId: String) -> Single<Result<PhotoResponse, NetworkError>>
}

enum PostAPICall {
    case getPosts
    case getPostDetails(postId: String)
    case getPostDetailComments(postId: String)
    case getPhoto(postId: String)

    var path: APIRequest {
        switch self {
        case .getPosts:
            return APIRequest(method: .get, path: "posts")
        case let .getPostDetails(postId):
            return APIRequest(method: .get, path: String(format: "posts/%@", postId))
        case let .getPostDetailComments(postId):
            return APIRequest(method: .get, path: String(format: "posts/%@/comments", postId))
        case let .getPhoto(postId):
            return APIRequest(method: .get, path: String(format: "photos/%@", postId))
        }
    }
}

final class PostAPIService: PostAPIServiceProtocol {

    // MARK: - Private Property

    private let serviceAPI: ServiceAPICallProtocol

    // MARK: - Initializer

    init(serviceAPI: ServiceAPICallProtocol) {
        self.serviceAPI = serviceAPI
    }

    // MARK: - Internal Methods

    func getPosts() -> Single<Result<[PostResponse], NetworkError>> {
        return serviceAPI.request(
            request: PostAPICall.getPosts.path,
            type: [PostResponse].self
        )
        .asSingle()
    }

    func getPostDetail(postId: String) -> Single<Result<PostResponse, NetworkError>> {
        return serviceAPI.request(
            request: PostAPICall.getPostDetails(postId: postId).path,
            type: PostResponse.self
        )
        .asSingle()
    }

    func getPostDetailComments(postId: String) -> Single<Result<[PostCommentsResponse], NetworkError>> {
        return serviceAPI.request(
            request: PostAPICall.getPostDetailComments(postId: postId).path,
            type: [PostCommentsResponse].self
        )
        .asSingle()
    }

    func getPhoto(postId: String) -> Single<Result<PhotoResponse, NetworkError>> {
        return serviceAPI.request(
            request: PostAPICall.getPhoto(postId: postId).path,
            type: PhotoResponse.self
        )
        .asSingle()
    }
}

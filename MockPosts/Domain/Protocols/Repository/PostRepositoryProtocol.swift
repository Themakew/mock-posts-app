//
//  PostRepositoryProtocol.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import RxSwift

protocol PostRepositoryProtocol {
    func getPosts() -> Single<Result<[PostEntity], NetworkError>>
    func getPostDetail(postId: String) -> Single<Result<PostEntity, NetworkError>>
    func getPostDetailComments(postId: String) -> Single<Result<[PostCommentsEntity], NetworkError>>
    func getPostIcon(postId: String) -> Single<Result<PhotoEntity, NetworkError>>
}

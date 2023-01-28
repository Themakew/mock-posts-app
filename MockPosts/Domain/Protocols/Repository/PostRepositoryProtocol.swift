//
//  PostRepositoryProtocol.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import RxSwift

protocol PostRepositoryProtocol {
    func getPosts() -> Single<Result<[PostResponse], NetworkError>>
    func getPostDetail(postId: String) -> Single<Result<PostResponse, NetworkError>>
    func getPostDetailComments(postId: String) -> Single<Result<[PostCommentsResponse], NetworkError>>
}

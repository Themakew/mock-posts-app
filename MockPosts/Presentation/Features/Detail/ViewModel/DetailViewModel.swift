//
//  DetailViewModel.swift
//  MockPosts
//
//  Created by Ruyther Costa on 2023-11-03.
//

import RxCocoa
import RxRelay
import RxSwift
import UIKit
import XCoordinator

protocol DetailViewModelProtocol {
    var input: DetailViewModelInput { get }
    var output: DetailViewModelOutput { get }
}

protocol DetailViewModelInput {
    var getPostDetail: PublishRelay<Void> { get }
}

protocol DetailViewModelOutput {
    var title: Driver<String> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var postTitle: Driver<String> { get }
    var postBody: Driver<String> { get }
    var commentsDataSource: BehaviorRelay<[PostCommentsEntity]?> { get }
}

extension DetailViewModelProtocol where Self: DetailViewModelInput & DetailViewModelOutput {
    var input: DetailViewModelInput { return self }
    var output: DetailViewModelOutput { return self }
}

final class DetailViewModel: DetailViewModelProtocol, DetailViewModelInput, DetailViewModelOutput {

    // MARK: - Internal Properties

    var getPostDetail = PublishRelay<Void>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    var title: Driver<String> = .just("Post Detail")
    var commentsDataSource = BehaviorRelay<[PostCommentsEntity]?>(value: nil)

    var postTitle: Driver<String> {
        return postTitleSubject.asDriver(onErrorJustReturn: "")
    }

    var postBody: Driver<String> {
        return postBodySubject.asDriver(onErrorJustReturn: "")
    }

    // MARK: - Private Properties

    private let disposeBag = DisposeBag()
    private let router: WeakRouter<HomeRouter>
    private let postId: String
    private let postUseCase: PostUseCaseProtocol
    private let postTitleSubject = BehaviorSubject<String>(value: "")
    private let postBodySubject = BehaviorSubject<String>(value: "")

    // MARK: - Initializer

    init(
        router: WeakRouter<HomeRouter>,
        postUseCase: PostUseCaseProtocol,
        postId: String
    ) {
        self.router = router
        self.postUseCase = postUseCase
        self.postId = postId

        bindRx()
    }

    // MARK: - Private Methods

    private func bindRx() {
        getPostDetail
            .do(onNext: { [weak self] _ in
                self?.isLoading.accept(true)
            })
            .flatMapLatest { _ -> Observable<(PostEntity?, [PostCommentsEntity]?, NetworkError?)> in
                return Observable.zip(
                    self.fetchPostDetail(),
                    self.fetchComments(),
                    resultSelector: { postDetailResult, commentsResult -> (PostEntity?, [PostCommentsEntity]?, NetworkError?) in
                        switch (postDetailResult, commentsResult) {
                        case let (.success(postDetail), .success(comments)):
                            return (postDetail, comments, nil)
                        case let (.failure(error), _), let (_, .failure(error)):
                            return (nil, nil, error)
                        default:
                            return (nil, nil, nil)
                        }
                    }
                )
            }
            .do(onNext: { [weak self] _ in
                self?.isLoading.accept(false)
            })
            .subscribe(onNext: { [weak self] postDetail, comments, error in
                if let error {
                    // TODO: Handle error
                    debugPrint(error)
                    return
                }

                if let postDetail {
                    self?.postTitleSubject.onNext(postDetail.title)
                    self?.postBodySubject.onNext(postDetail.body)
                }

                if let comments {
                    self?.commentsDataSource.accept(comments)
                }
            })
            .disposed(by: disposeBag)
    }

    private func fetchPostDetail() -> Observable<Result<PostEntity, NetworkError>> {
        return postUseCase.getPostDetail(postId: postId).asObservable()
    }

    private func fetchComments() -> Observable<Result<[PostCommentsEntity], NetworkError>> {
        return postUseCase.getPostDetailComments(postId: postId).asObservable()
    }
}

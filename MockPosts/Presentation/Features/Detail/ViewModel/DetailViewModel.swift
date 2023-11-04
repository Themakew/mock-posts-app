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
        let responseResultObservable = getPostDetail
            .do(onNext: { [weak self] _ in
                self?.isLoading.accept(true)
            })
            .flatMap(weak: self) { this, _ -> Observable<Result<PostEntity, NetworkError>> in
                return this.postUseCase.getPostDetail(postId: String(this.postId))
                    .asObservable()
            }
            .do(onNext: { [weak self] _ in
                self?.isLoading.accept(false)
            })
            .share()

        responseResultObservable
            .withUnretained(self)
            .subscribe(onNext: { this, result in
                switch result {
                case let .success(response):
                    this.postTitleSubject.onNext(response.title)
                    this.postBodySubject.onNext(response.body)
                case let .failure(error):
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}

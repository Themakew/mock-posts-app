//
//  HomeViewModel.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import RxCocoa
import RxRelay
import RxSwift
import UIKit
import XCoordinator

protocol HomeViewModelProtocol {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

protocol HomeViewModelInput {
    var getPosts: PublishRelay<Void> { get }
    var postSelected: PublishRelay<PostEntity> { get }
}

protocol HomeViewModelOutput {
    var title: Driver<String> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var dataSource: BehaviorRelay<[PostEntity]?> { get }
}

extension HomeViewModelProtocol where Self: HomeViewModelInput & HomeViewModelOutput {
    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
}

final class HomeViewModel: HomeViewModelProtocol, HomeViewModelInput, HomeViewModelOutput {

    // MARK: - Internal Properties

    var getPosts = PublishRelay<Void>()
    var dataSource = BehaviorRelay<[PostEntity]?>(value: nil)
    var title: Driver<String> = .just("Posts")
    var postSelected = PublishRelay<PostEntity>()
    var isLoading = BehaviorRelay<Bool>(value: false)

    // MARK: - Private Properties

    private let disposeBag = DisposeBag()
    private let router: WeakRouter<HomeRouter>
    private let postUseCase: PostUseCaseProtocol

    // MARK: - Initializer

    init(
        router: WeakRouter<HomeRouter>,
        postUseCase: PostUseCaseProtocol
    ) {
        self.router = router
        self.postUseCase = postUseCase

        bindRx()
    }

    // MARK: - Private Methods

    private func bindRx() {
        let responseResultObservable = getPosts
            .do(onNext: { [weak self] _ in
                self?.isLoading.accept(true)
            })
            .flatMap(weak: self) { this, _ -> Observable<Result<[PostEntity], NetworkError>> in
                return this.postUseCase.getPosts()
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
                    this.dataSource.accept(response)
                case let .failure(error):
                    break
                }
            })
            .disposed(by: disposeBag)

        postSelected
            .withUnretained(self)
            .subscribe(onNext: { this, post in
                this.router.trigger(.detail(String(post.id)))
            })
            .disposed(by: disposeBag)
    }
}

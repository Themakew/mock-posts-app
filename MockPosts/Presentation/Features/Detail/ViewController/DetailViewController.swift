//
//  DetailViewController.swift
//  MockPosts
//
//  Created by Ruyther Costa on 2023-11-03.
//

import RxSwift
import UIKit

final class DetailViewController: UIViewController {

    // MARK: - Private Properties

    private let disposeBag = DisposeBag()
    private let viewModel: DetailViewModelProtocol
    private let customView = DetailView()

    // MARK: - Initializers

    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindRx()

        viewModel.input.getPostDetail.accept(())
    }
}

// MARK: - BindRx Extension

extension DetailViewController {
    private func bindRx() {
        viewModel.output.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        viewModel.output.postTitle
            .drive(customView.titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.postBody
            .drive(customView.descriptionLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.isLoading
            .asObservable()
            .observe(on: MainScheduler.asyncInstance)
            .bind { [weak self] isLoading in
                if isLoading {
                    self?.customView.activityIndicator.startAnimating()
                } else {
                    self?.customView.activityIndicator.stopAnimating()
                }
            }
            .disposed(by: disposeBag)
    }
}

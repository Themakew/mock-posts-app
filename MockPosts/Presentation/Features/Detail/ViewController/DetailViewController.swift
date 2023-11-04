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
        customView.tableView.register(cellClass: CommentCell.self)
        bindRx()

        viewModel.input.getPostDetail.accept(())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
}

// MARK: - BindRx Extension

extension DetailViewController {
    private func bindRx() {
        customView.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        viewModel.output.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        viewModel.output.postTitle
            .debug()
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

        viewModel.output.commentsDataSource
            .filterNotNil()
            .do(onNext: { [weak self] comments in
                self?.customView.setupFixedTitle(with: comments.count)
            })
            .bind(to: customView.tableView.rx.items) { [weak self] _, row, dataSource in
                let indexPath = IndexPath(row: row, section: 0)

                guard let self else {
                    return UITableViewCell()
                }

                let cell = self.customView.tableView.dequeue(cellClass: CommentCell.self, indexPath: indexPath)
                cell.configure(content: dataSource)

                return cell
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate Extension

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

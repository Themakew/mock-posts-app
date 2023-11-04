//
//  HomeViewController.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import RxSwift
import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Private Properties

    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModelProtocol
    private let customView = HomeView()

    // MARK: - Initializers

    init(viewModel: HomeViewModelProtocol) {
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
        customView.tableView.register(cellClass: PostCell.self)

        bindRx()

        viewModel.input.getPosts.accept(())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = customView.tableView.indexPathForSelectedRow {
            customView.tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}

// MARK: - BindRx Extension

extension HomeViewController {
    private func bindRx() {
        customView.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        customView.refreshControl.rx.controlEvent(.valueChanged)
            .bind { [weak self] in
                self?.viewModel.input.getPosts.accept(())
            }
            .disposed(by: disposeBag)

        viewModel.output.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        viewModel.output.isLoading
            .asObservable()
            .observe(on: MainScheduler.asyncInstance)
            .bind { [weak self] isLoading in
                if isLoading {
                    self?.customView.activityIndicator.startAnimating()
                } else {
                    self?.customView.refreshControl.endRefreshing()
                    self?.customView.activityIndicator.stopAnimating()
                }
            }
            .disposed(by: disposeBag)

        viewModel.output.dataSource
            .filterNotNil()
            .bind(to: customView.tableView.rx.items) { [weak self] _, row, dataSource in
                let indexPath = IndexPath(row: row, section: 0)

                guard let self else {
                    return UITableViewCell()
                }

                let cell = self.customView.tableView.dequeue(cellClass: PostCell.self, indexPath: indexPath)
                cell.configure(content: dataSource)

                return cell
            }
            .disposed(by: disposeBag)

        customView.tableView.rx.modelSelected(PostEntity.self)
            .bind(to: viewModel.input.postSelected)
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate Extension

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

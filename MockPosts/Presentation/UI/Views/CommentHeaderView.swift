//
//  CommentHeaderView.swift
//  MockPosts
//
//  Created by Ruyther Costa on 2023-11-03.
//

import UIKit

final class CommentHeaderView: UIView {

    // MARK: - Private Properties

    private let titleLabel = UILabel(translateMask: false).apply {
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.textAlignment = .center
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal Methods

    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}

// MARK: - ViewCode Extension

extension CommentHeaderView: ViewCode {
    func buildViewHierarchy() {
        addSubview(titleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

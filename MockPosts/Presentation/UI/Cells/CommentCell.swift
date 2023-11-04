//
//  CommentCell.swift
//  MockPosts
//
//  Created by Ruyther Costa on 2023-11-03.
//

import RxRelay
import RxSwift
import UIKit

final class CommentCell: UITableViewCell {

    // MARK: - Private Properties

    private let iconImageView = UIImageView(translateMask: false).apply {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "person-icon")
        $0.layer.masksToBounds = true
    }

    private let nameLabel = UILabel(translateMask: false).apply {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
        $0.tintColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    private let emailLabel = UILabel(translateMask: false).apply {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
        $0.tintColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }

    private let commentLabel = UILabel(translateMask: false).apply {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.tintColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }

    private let topStackView = UIStackView(translateMask: false).apply {
        $0.spacing = 4
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
    }

    private let userStackView = UIStackView(translateMask: false).apply {
        $0.spacing = 4
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }

    private let generalStackView = UIStackView(translateMask: false).apply {
        $0.spacing = 4
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View LifeCycle

    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width / 2
    }
}

// MARK: - ViewCode Extension

extension CommentCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(topStackView)
        contentView.addSubview(generalStackView)

        userStackView.addArrangedSubview(nameLabel)
        userStackView.addArrangedSubview(emailLabel)

        topStackView.addArrangedSubview(iconImageView)
        topStackView.addArrangedSubview(userStackView)

        generalStackView.addArrangedSubview(commentLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),

            topStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            topStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            generalStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 8),
            generalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            generalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            generalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

// MARK: - Configuration Extension

extension CommentCell: Configurable {
    typealias Configuration = PostCommentsEntity

    func configure(content: Configuration) {
        nameLabel.text = content.name
        emailLabel.text = content.email
        commentLabel.text = content.comment
    }
}

//
//  PostCell.swift
//  MockPosts
//
//  Created by Ruyther Costa on 30/01/23.
//

import Kingfisher
import RxRelay
import RxSwift
import UIKit

final class PostCell: UITableViewCell {

    // MARK: - Private Properties

    private let postImageView = UIImageView(translateMask: false)
    private let titleLabel = UILabel(translateMask: false).apply {
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.tintColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 0
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

    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.kf.cancelDownloadTask()

        postImageView.image = UIImage(named: "placeholder-icon")
        titleLabel.text = nil
    }

}

// MARK: - ViewCode Extension

extension PostCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            postImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -15),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            postImageView.widthAnchor.constraint(equalToConstant: 70),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),

            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

// MARK: - Configuration Extension

extension PostCell: Configurable {
    typealias Configuration = PostEntity

    func configure(content: Configuration) {
        titleLabel.text = content.title
        postImageView.setImageWithKingfisher(content.iconURL)
    }
}

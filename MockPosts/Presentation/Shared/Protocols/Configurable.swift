//
//  Configurable.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

protocol Configurable {
    associatedtype Configuration

    func configure(content: Configuration)
}

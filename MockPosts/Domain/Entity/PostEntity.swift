//
//  PostEntity.swift
//  MockPosts
//
//  Created by Ruyther Costa on 30/01/23.
//

struct PostEntity: Equatable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    var iconURL: String
    var isFavorite: Bool
}

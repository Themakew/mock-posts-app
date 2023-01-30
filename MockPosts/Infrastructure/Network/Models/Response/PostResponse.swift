//
//  PostResponse.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

struct PostResponse: Decodable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

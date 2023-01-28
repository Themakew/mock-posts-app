//
//  PostCommentsResponse.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

struct PostCommentsResponse: Decodable {
    let userId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

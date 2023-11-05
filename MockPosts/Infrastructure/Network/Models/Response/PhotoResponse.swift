//
//  PhotoResponse.swift
//  MockPosts
//
//  Created by Ruyther Costa on 2023-11-04.
//

struct PhotoResponse: Decodable, Equatable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

//
//  APIRequest.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import Alamofire

enum BaseURL: String {
    case primary = "https://jsonplaceholder.typicode.com/"
}

struct APIRequest {

    // MARK: - Internal Properties

    let url: String
    let method: HTTPMethod
    let encodeType: ParameterEncoding

    // MARK: - Private Properties

    private let baseURL: BaseURL
    private let path: String

    // MARK: - Initializer

    init(
        method: HTTPMethod,
        baseURL: BaseURL = .primary,
        path: String,
        encodeType: ParameterEncoding = URLEncoding.default
    ) {
        self.method = method
        self.baseURL = baseURL
        self.path = path
        self.encodeType = encodeType
        self.url = baseURL.rawValue + path
    }
}

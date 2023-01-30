//
//  NetworkError.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case decodeError
    case noAPIResponse
    case httpResponseError(statusCode: Int)
    case genericError(error: String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .urlError:
            return "API Error: Invalid URL"
        case .decodeError:
            return "API Error: Decoding Error"
        case .noAPIResponse:
            return "API Error: No API Response"
        case let .httpResponseError(statusCode):
            return "API Error: HTTP Code \(statusCode)"
        case let .genericError(error):
            return error
        }
    }
}

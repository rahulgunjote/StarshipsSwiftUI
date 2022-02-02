//
//  APIError.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import Foundation

enum APIError: Error, LocalizedError {
    case urlRequest
    case network
    case server
    case generic
    case decoding

    var errorDescription: String? {
        switch self {
        case .urlRequest:
            return "The request could not be completed."
        case .network:
            return
                """
                We could not connect to the network. \
                Please check your internet connection, or try again later.
                """
        case .server:
            return "We could not connect to the server."
            case .decoding:
                return "We could not interpret data sent by server."
        case .generic:
            return "Something went wrong. Please try again later."
                
        }
    }
}



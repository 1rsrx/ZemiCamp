//
//  ApiError.swift
//  ZemiCampApp
//
//  Created by r on 2023/08/11.
//

import Foundation

enum ApiError: Error {
    case network
    case invalidResponse
    case httpError(code: Int)
    case parse
    
    case other(message: String)
    
    var localizedDescription: String {
        switch self {
        case .network:
            return "network error"
        case .invalidResponse:
            return "invalid response"
        case .httpError(code: let code):
            return "http error code: \(code)"
        case .parse:
            return "parse error"
        case .other(message: let message):
            return "other error: \(message)"
        }
    }
}

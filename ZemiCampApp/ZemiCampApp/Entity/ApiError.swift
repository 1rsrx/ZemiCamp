//
//  ApiError.swift
//  ZemiCampApp
//
//  Created by r on 2023/08/11.
//

import Foundation

enum NetworkError: Error {
    case network
    case invalidResponse
    case httpError(statusCode: Int)
    case parse
    
    var localizedDescription: String {
        switch self {
        case .network:
            return "通信エラー"
        case .invalidResponse:
            return "無効なレスポンス"
        case .httpError(statusCode: let statusCode):
            return "エラー ステータスコード: \(statusCode)"
        case .parse:
            return "パースエラー"
        }
    }
}

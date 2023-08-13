//
//  SearchRepositoryApi.swift
//  ZemiCampApp
//
//  Created by r on 2023/08/13.
//

import Foundation

class RepositoryLoader {
    
    func fetchRepositories(keyword: String) async throws -> SearchRepositoryResult {
        let baseURL = "https://api.github.com/search/repositories"
        let url = URL(string: baseURL + "?q=" + keyword)!
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            let statusCode = httpResponse.statusCode
            if !(200...299).contains(statusCode) {
                throw NetworkError.httpError(statusCode: statusCode)
            }
            
            do {
                let result = try JSONDecoder().decode(SearchRepositoryResult.self, from: data)
                return result
            } catch {
                throw NetworkError.parse
            }
        } catch {
            throw NetworkError.network
        }
    }
}

//
//  ImageLoader.swift
//  ZemiCampApp
//
//  Created by r on 2023/08/11.
//

import UIKit

class ImageLoader {
    
    func fetchImage(from url: URL) async throws -> UIImage? {
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
            
            if let image = UIImage(data: data) {
                return image
            } else {
                return nil
            }
        } catch {
            throw NetworkError.network
        }
    }
}

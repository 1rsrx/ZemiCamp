//
//  ImageLoader.swift
//  ZemiCampApp
//
//  Created by r on 2023/08/11.
//

import UIKit

class ImageLoader {
    
    func fetchImage(from url: URL) async -> Result<UIImage, ApiError> {
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            
            let statusCode = httpResponse.statusCode
            if !(200...299).contains(statusCode) {
                return .failure(.httpError(code: statusCode))
            }
            
            guard let image = UIImage(data: data) else {
                return .failure(.other(message: "failed Data to UIImage"))
            }
            
            return .success(image)
        } catch {
            return .failure(.other(message: error.localizedDescription))
        }
    }
}

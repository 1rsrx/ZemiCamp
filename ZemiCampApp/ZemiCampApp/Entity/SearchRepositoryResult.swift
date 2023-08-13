//
//  SearchRepositoryResult.swift
//  ZemiCampApp
//
//  Created by r on 2023/08/13.
//

import Foundation

struct SearchRepositoryResult: Decodable {
    var total_count: Int
    var items: [Item]
    
    struct Item: Decodable {
        var id: Int
        var name: String
        var html_url: String
    }
}

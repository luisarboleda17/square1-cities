//
//  PaginationResult.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/23/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation

struct PaginationResult {
    let currentPage: Int
    let lastPage: Int
    let perPage: Int
    let total: Int
}

extension PaginationResult: Decodable {
    enum ResultKeys: String, CodingKey {
        case currentPage = "current_page"
        case lastPage = "last_page"
        case perPage = "per_page"
        case total = "total"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultKeys.self)
        
        self.init(
            currentPage: try container.decode(Int.self, forKey: .currentPage),
            lastPage: try container.decode(Int.self, forKey: .lastPage),
            perPage: try container.decode(Int.self, forKey: .perPage),
            total: try container.decode(Int.self, forKey: .total)
        )
    }
}

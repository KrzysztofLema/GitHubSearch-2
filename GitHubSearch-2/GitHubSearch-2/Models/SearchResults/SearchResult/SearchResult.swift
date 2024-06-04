//
//  SearchResult.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 21/05/2024.
//

import Foundation

struct SearchResult: Hashable {
    let totalCount: Int
    let items: [Item]
    let identifier = UUID().uuidString
    
    init(dto: SearchResultResponseDTO) {
        self.totalCount = dto.totalCount ?? 0
        self.items = dto.items?.map(Item.init) ?? [Item]()
    }
    
    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

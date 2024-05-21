//
//  SearchResult.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 21/05/2024.
//

import Foundation

struct SearchResult {
    let totalCount: Int
    let items: [Item]
    
    init(dto: SearchResultResponseDTO) {
        self.totalCount = dto.totalCount ?? 0
        self.items = dto.items?.map(Item.init) ?? [Item]()
    }
}

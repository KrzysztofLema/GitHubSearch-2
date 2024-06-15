//
//  SearchResult.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 21/05/2024.
//

import Foundation
import GHSDtoModels

public struct SearchResult: Hashable {
    public let totalCount: Int
    public let items: [Item]
    public let identifier = UUID().uuidString

    public init(dto: SearchResultResponseDTO) {
        totalCount = dto.totalCount ?? 0
        items = dto.items?.map(Item.init) ?? [Item]()
    }

    public static func ==(lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

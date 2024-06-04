//
//  Item.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 21/05/2024.
//

import Foundation

struct Item: Equatable, Hashable {
    private let uuid: UUID = UUID()

    var id: Int?
    var name: String?
    var fullName: String?
    var owner: Owner
    var htmlUrl: URL?
    var description: String?
    var language: String?
    var forksCount: Int
    var updatedAt: Date
    var stargazersCount: Int
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    public static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.uuid == rhs.uuid
    }
}

extension Item {
    init(dto: ItemDTO) {
        id = dto.id
        name = dto.name
        fullName = dto.fullName
        owner = Owner(dto: dto.owner)
        htmlUrl = URL(string: dto.htmlUrl ?? "")
        description = dto.description
        language = dto.language
        forksCount = dto.forksCount ?? 0
        updatedAt = dto.updatedAt ?? .now
        stargazersCount = dto.stargazersCount ?? 0
    }
}

//
//  Item.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 21/05/2024.
//

import Foundation

struct Item: Equatable {
    var id: Int?
    var name: String?
    var fullName: String?
    var owner: Owner
    var htmlUrl: URL?
    var description: String?
}

extension Item {
    init(dto: ItemDTO) {
        id = dto.id
        name = dto.name
        fullName = dto.htmlUrl
        owner = Owner(dto: dto.owner)
        htmlUrl = URL(string: dto.htmlUrl ?? "")
        description = dto.description
    }
}

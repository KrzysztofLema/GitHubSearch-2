//
//  Item.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 21/05/2024.
//

import Foundation

struct Item {
    var id: Int?
    var name: String?
    var fullName: String?
    var owner: Owner
    var url: URL?
    var description: String?
}

extension Item {
    init(dto: ItemDTO) {
        id = dto.id
        name = dto.name
        fullName = dto.htmlUrl
        owner = Owner(dto: dto.owner)
        url = URL(string: dto.url ?? "")
        description = dto.description
    }
}

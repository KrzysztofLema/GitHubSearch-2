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
    var url: URL?
    var description: String?
    var owner: Owner
}

extension Item {
    init(dto: ItemDTO) {
        id = dto.id
        name = dto.name
        url = URL(string: dto.url ?? "")
        description = dto.description
        owner = Owner(dto: dto.owner)
    }
}

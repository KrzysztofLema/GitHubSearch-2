//
//  Owner.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 21/05/2024.
//

import Foundation

struct Owner {
    var avatar: URL?
    
    init(dto: OwnerDTO?) {
        self.avatar = URL(string: dto?.avatarUrl ?? "")
    }
}

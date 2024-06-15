//
//  Owner.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 21/05/2024.
//

import Foundation
import GHSDtoModels

public struct Owner: Equatable {
    public var avatar: URL?

    init(dto: OwnerDTO?) {
        avatar = URL(string: dto?.avatarUrl ?? "")
    }
}

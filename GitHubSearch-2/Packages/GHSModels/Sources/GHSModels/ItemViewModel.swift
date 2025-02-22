//
//  ItemViewModel.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 02/06/2024.
//

import Foundation

public final class ItemViewModel {
    public var stargazers: String {
//        item.stargazersCount.roundedWithAbbreviations
        return " item.stargazersCount.roundedWithAbbreviations"
    }

    public var updatedAtText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"

        let date = formatter.string(from: item.updatedAt)

        return "Updated on \(date)"
    }

    public let item: Item

    public init(item: Item) {
        self.item = item
    }
}

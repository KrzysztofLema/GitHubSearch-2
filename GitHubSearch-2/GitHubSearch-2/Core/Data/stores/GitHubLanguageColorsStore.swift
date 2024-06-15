//
//  GitHubLanguageColorsStore.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 03/06/2024.
//

import GHSDtoModels
import GHSModels
import UIKit

protocol LanguageColorsStoreType {
    func getColor(for language: String) -> UIColor?
}

public final class LanguageColorsStore: LanguageColorsStoreType {
    typealias GitHubLanguageColorsValuesDTO = [String: GitHubLanguageColorsDTO]
    typealias GitHubLanguageColorsValues = [String: GitHubLanguageColors]

    private var colors: GitHubLanguageColorsValues?
    private let decoder = JSONDecoder()

    init() {
        colors = loadJSONValues()
    }

    func getColor(for language: String) -> UIColor? {
        colors?[language]?.color
    }

    private func loadJSONValues() -> GitHubLanguageColorsValues {
        guard let url = Bundle.main.url(forResource: "GitHubLanguageColors", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let colors = try? decoder.decode(GitHubLanguageColorsValuesDTO.self, from: data) else {
            return [:]
        }

        return colors.mapValues { GitHubLanguageColors(dto: $0) }
    }
}

struct LanguageColorsStoreKey: InjectionKey {
    static var currentValue: LanguageColorsStoreType = LanguageColorsStore()
}

extension InjectedValues {
    var languageColorStore: LanguageColorsStoreType {
        get { Self[LanguageColorsStoreKey.self] }
        set { Self[LanguageColorsStoreKey.self] = newValue }
    }
}

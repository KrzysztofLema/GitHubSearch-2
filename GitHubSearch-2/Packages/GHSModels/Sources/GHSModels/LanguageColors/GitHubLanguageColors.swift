//
//  GitHubLanguageColors.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 03/06/2024.
//

import GHSCoreUI
import UIKit

public struct GitHubLanguageColors {
    public let color: UIColor?
    public let url: URL?

    public init(dto: GitHubLanguageColorsDTO) {
        color = UIColor(hexString: dto.color ?? "")
        url = URL(string: dto.url)
    }
}

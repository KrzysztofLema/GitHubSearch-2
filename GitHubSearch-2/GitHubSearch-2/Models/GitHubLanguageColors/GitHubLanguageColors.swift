//
//  GitHubLanguageColors.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 03/06/2024.
//

import UIKit

struct GitHubLanguageColors {
    let color: UIColor?
    let url: URL?

    init(dto: GitHubLanguageColorsDTO) {
        color = UIColor(hexString: dto.color ?? "")
        url = URL(string: dto.url)
    }
}

//
//  Optional+Extensions.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 04/06/2024.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}

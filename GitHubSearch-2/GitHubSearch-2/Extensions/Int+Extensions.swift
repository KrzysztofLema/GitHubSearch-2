//
//  Int+Extensions.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 02/06/2024.
//

import Foundation

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000

        if million >= 1.0 {
            return "\(round(million * 10) / 10)M"
        } else if thousand >= 1.0 {
            return "\(round(thousand * 10) / 10)k"
        } else {
            return "\(self)"
        }
    }
}

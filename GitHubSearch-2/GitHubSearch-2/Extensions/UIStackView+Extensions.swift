//
//  UIStackView+Extensions.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 14/06/2024.
//

import UIKit

public extension UIStackView {
    func removeAllArrangedSubviews() {
        for subview in arrangedSubviews {
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}

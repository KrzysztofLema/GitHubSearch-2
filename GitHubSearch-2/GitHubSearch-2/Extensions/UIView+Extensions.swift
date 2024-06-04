//
//  UIView+Extensions.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 04/06/2024.
//

import UIKit

extension UIView {
    func asCircle() {
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
    }
}

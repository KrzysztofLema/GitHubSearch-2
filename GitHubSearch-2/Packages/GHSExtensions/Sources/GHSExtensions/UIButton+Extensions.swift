//
//  UIButton+Extensions.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 13/06/2024.
//

import Foundation
import UIKit

extension UIButton {
    public func underline() {
        guard let text = titleLabel?.text else {
            return
        }

        let attributedString = NSAttributedString(string: text, attributes: [.underlineStyle: NSUnderlineStyle.thick.rawValue])

        setAttributedTitle(attributedString, for: .normal)
    }
}

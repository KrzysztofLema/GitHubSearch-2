//
//  SettingsOption.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 11/06/2024.
//

import Foundation
import UIKit

struct SettingsSection {
    var title: String?
    var settingsOption: [SettingsOption]
}

struct SettingsOption {
    let title: String
    let titleTextColor: UIColor
    let icon: UIImage?
    let backgroundColor: UIColor
    let imageTintColor: UIColor?
    var didSelect: (() -> Void)?
}

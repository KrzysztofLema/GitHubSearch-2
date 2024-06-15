//
//  SettingsOption.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 11/06/2024.
//

import Foundation
import UIKit

public struct SettingsSection {
    public var title: String?
    public var settingsOption: [SettingsOption]

    public init(
        title: String? = "",
        settingsOption: [SettingsOption]
    ) {
        self.title = title
        self.settingsOption = settingsOption
    }
}

public struct SettingsOption {
    public let title: String
    public let titleTextColor: UIColor
    public let icon: UIImage?
    public let backgroundColor: UIColor
    public let imageTintColor: UIColor?
    public var didSelect: (() -> Void)?

    public init(
        title: String,
        titleTextColor: UIColor, 
        icon: UIImage?,
        backgroundColor: UIColor,
        imageTintColor: UIColor?,
        didSelect: (() -> Void)?
    ) {
        self.title = title
        self.titleTextColor = titleTextColor
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.imageTintColor = imageTintColor
        self.didSelect = didSelect
    }
}

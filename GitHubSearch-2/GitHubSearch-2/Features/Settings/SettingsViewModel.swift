//
//  SettingsViewModel.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 11/06/2024.
//

import CocoaLumberjackSwift
import Foundation
import GHSModels
import UIKit

protocol SettingsViewModelDelegate: AnyObject {
    func settingsViewModelDidTapLogOut(_ settingsViewModel: SettingsViewModel)
}

final class SettingsViewModel {
    var models: [SettingsSection] = []

    weak var delegate: SettingsViewModelDelegate?

    init() {
        configure()
    }

    func logOut() {
        DDLogInfo("User tap log out button")
        delegate?.settingsViewModelDidTapLogOut(self)
    }

    func configure() {
        models = [
            SettingsSection(
                settingsOption: [
                    createLogOutSettingsOption(),
                ]
            ),
        ]
    }
}

private extension SettingsViewModel {
    func createLogOutSettingsOption() -> SettingsOption {
        SettingsOption(
            title: "Log out",
            titleTextColor: .white,
            icon: UIImage(systemName: UIConstants.Image.logoutIconImageTitle),
            backgroundColor: Color.redButtonBackground,
            imageTintColor: Color.whiteTextColor
        ) {
            self.logOut()
        }
    }
}

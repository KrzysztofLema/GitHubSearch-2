//
//  SettingsViewController.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import UIKit

final class SettingsViewController: BasicViewController {
    private let viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        title = "Settings"
    }

    override func loadView() {
        view = SettingsView(viewModel: viewModel)
    }
}

//
//  SettingsTabScreenCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import UIKit

protocol SettingsScreenCoordinatorDelegate: AnyObject {
    func settingsScreenDidLogOut(_ settingsScreenCoordinator: SettingsScreenCoordinator)
}

final class SettingsScreenCoordinator: Coordinator {
    
    public weak var delegate: SettingsScreenCoordinatorDelegate?
    
    override func start() {
        let settingsViewController = makeSettingsViewController()
        navigationController.setViewControllers([settingsViewController], animated: true)
    }
    
    private func makeSettingsViewController() -> SettingsViewController {
        let viewModel = SettingsViewModel()
        viewModel.delegate = self
        
        let viewController = SettingsViewController(viewModel: viewModel)
        return viewController
    }
}

extension SettingsScreenCoordinator: SettingsViewModelDelegate {
    func settingsViewModelDidTapLogOut(_ settingsViewModel: SettingsViewModel) {
        delegate?.settingsScreenDidLogOut(self)
    }
}

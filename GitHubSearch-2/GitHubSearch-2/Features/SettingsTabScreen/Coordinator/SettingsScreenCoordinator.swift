//
//  SettingsTabScreenCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import UIKit

final class SettingsScreenCoordinator: Coordinator {
    
    let rootViewController = UINavigationController()
    
    override func start() {
        let settingsViewController = makeSettingsViewController()
        rootViewController.setViewControllers([settingsViewController], animated: true)
    }
    
    private func makeSettingsViewController() -> SettingsViewController {
        let viewController = SettingsViewController()
        return viewController
    }
}

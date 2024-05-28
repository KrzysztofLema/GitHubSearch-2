//
//  MainCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import UIKit

protocol TabBarCoordinatorDelegate: AnyObject {
    func repositoryListViewCoordinatorDidSelectRow(_ coordinator: TabBarCoordinator)
}

final class TabBarCoordinator: Coordinator {
    
    weak var delegate: TabBarCoordinatorDelegate?
    
    override func start() {
        navigationController.navigationBar.isHidden = true
        let rootViewController = TabBarViewController(
            repositoryListViewCoordinator: makeRepositoryListViewCoordinator(),
            settingsScreenCoordinator: makeSettingsScreenViewCoordinator()
        )
        navigationController.pushViewController(rootViewController, animated: true)
    }
}

private extension TabBarCoordinator {
    func makeSettingsScreenViewCoordinator() -> SettingsScreenCoordinator {
        let settingsScreenCoordinator = SettingsScreenCoordinator(navigationController: UINavigationController())
        settingsScreenCoordinator.start()
        
        addChild(settingsScreenCoordinator)
        
        return settingsScreenCoordinator
    }
    
    func makeRepositoryListViewCoordinator() -> RepositoryListViewCoordinator {
        let repositoryListViewCoordinator = RepositoryListViewCoordinator(navigationController: UINavigationController())
        repositoryListViewCoordinator.start()
        
        repositoryListViewCoordinator.delegate = self
        
        addChild(repositoryListViewCoordinator)
        
        return repositoryListViewCoordinator
    }
}

extension TabBarCoordinator: RepositoryListViewCoordinatorDelegate {
    func repositoryListViewCoordinatorDidSelectRow(_ coordinator: RepositoryListViewCoordinator) {
        delegate?.repositoryListViewCoordinatorDidSelectRow(self)
    }
}

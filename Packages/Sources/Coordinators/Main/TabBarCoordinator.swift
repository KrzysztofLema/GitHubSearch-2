//
//  TabBarCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import Settings
import UIKit

protocol TabBarCoordinatorDelegate: AnyObject {
    func repositoryListViewCoordinator(_ coordinator: TabBarCoordinator, didSelect item: Item)
    func settingsScreenDidLogOut(_ coordinator: TabBarCoordinator)
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

        settingsScreenCoordinator.delegate = self

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
    func repositoryListViewCoordinator(_ coordinator: RepositoryListViewCoordinator, didSelect item: Item) {
        delegate?.repositoryListViewCoordinator(self, didSelect: item)
    }
}

extension TabBarCoordinator: SettingsScreenCoordinatorDelegate {
    func settingsScreenDidLogOut(_ settingsScreenCoordinator: SettingsScreenCoordinator) {
        delegate?.settingsScreenDidLogOut(self)
    }
}

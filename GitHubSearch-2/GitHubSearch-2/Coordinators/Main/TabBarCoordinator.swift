//
//  MainCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    override func start() {
        let rootViewController = TabBarViewController(
            mainScreenCoordinator: makeMainScreenCoordinator(),
            settingsScreenCoordinator: makeSettingsScreenViewCoordinator()
        )
        navigationController.pushViewController(rootViewController, animated: true)
    }
}

private extension TabBarCoordinator {
    func makeSettingsScreenViewCoordinator() -> SettingsScreenCoordinator {
        let settingsScreenCoordinator = SettingsScreenCoordinator(navigationController: navigationController)
        settingsScreenCoordinator.start()
        
        addChild(settingsScreenCoordinator)
        
        return settingsScreenCoordinator
    }
    
    func makeMainScreenCoordinator() -> MainScreenCoordinator {
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController)
        mainScreenCoordinator.start()
        
        addChild(mainScreenCoordinator)
        
        return mainScreenCoordinator
    }
}

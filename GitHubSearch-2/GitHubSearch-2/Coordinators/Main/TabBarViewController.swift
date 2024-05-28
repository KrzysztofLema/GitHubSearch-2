//
//  TabBarViewController.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 19/05/2024.
//

import UIKit
import TinyConstraints

final class TabBarViewController: UITabBarController {
    
    let repositoryListViewCoordinator: RepositoryListViewCoordinator
    let settingsScreenCoordinator: SettingsScreenCoordinator
    
    init(repositoryListViewCoordinator: RepositoryListViewCoordinator, settingsScreenCoordinator: SettingsScreenCoordinator) {
        self.repositoryListViewCoordinator = repositoryListViewCoordinator
        self.settingsScreenCoordinator = settingsScreenCoordinator
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabBarViewController {
    func setupView() {
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .lightGray
        
        let settingsScreenViewController = settingsScreenCoordinator.navigationController
        let repositoryListNavigationController = repositoryListViewCoordinator.navigationController
                
        repositoryListNavigationController.tabBarItem = UITabBarItem(title: "Main Screen", image: UIImage(systemName: "house"), tag: 0)
        settingsScreenViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
        viewControllers = [repositoryListNavigationController, settingsScreenViewController]
    }
}

//
//  TabBarViewController.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 19/05/2024.
//

import UIKit
import TinyConstraints

final class TabBarViewController: UITabBarController {
    
    let mainScreenCoordinator: MainScreenCoordinator
    let settingsScreenCoordinator: SettingsScreenCoordinator
    
    init(mainScreenCoordinator: MainScreenCoordinator, settingsScreenCoordinator: SettingsScreenCoordinator) {
        self.mainScreenCoordinator = mainScreenCoordinator
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
        
        let settingsScreenViewController = settingsScreenCoordinator.rootViewController
        let mainScreenViewController = mainScreenCoordinator.rootViewController
        
        mainScreenViewController.tabBarItem = UITabBarItem(title: "Main Screen", image: UIImage(systemName: "house"), tag: 0)
        settingsScreenViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
        viewControllers = [mainScreenViewController, settingsScreenViewController]
    }
}

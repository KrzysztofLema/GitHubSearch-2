//
//  MainScreenCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import UIKit

final class MainScreenCoordinator: Coordinator {
    
    let rootViewController = UINavigationController()
    
    override func start() {
        let mainScreenViewController = mainScreenViewController()
     
        rootViewController.setViewControllers([mainScreenViewController], animated: true)
    }
    
    private func mainScreenViewController() -> MainViewController {
        let viewController = MainViewController()
        return viewController
    }
}

//
//  RepositoryDetailCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 27/05/2024.
//

import Foundation

final class RepositoryDetailCoordinator: Coordinator {
    override func start() {
        let viewController = makeRepositoryDetailViewController()
     
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func makeRepositoryDetailViewController() -> RepositoryDetailViewController {
        let viewModel = RepositoryDetailViewModel()
        let viewController = RepositoryDetailViewController()
        return viewController
    }
}

//
//  RepositorySearchScreenCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import UIKit

protocol RepositoryListViewCoordinatorDelegate: AnyObject {
    func repositoryListViewCoordinatorDidSelectRow(_ coordinator: RepositoryListViewCoordinator)
}

final class RepositoryListViewCoordinator: Coordinator {
    
    weak var delegate: RepositoryListViewCoordinatorDelegate?
    
    override func start() {
        let viewController = makeRepositoryListViewController()
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func makeRepositoryListViewController() -> RepositoryListViewController {
        let viewModel = RepositoryListViewModel()
        let viewController = RepositoryListViewController(viewModel: viewModel)
        
        viewController.delegate = self
        
        return viewController
    }
}

extension RepositoryListViewCoordinator: RepositoryListViewControllerDelegate {
    func repositoryListViewControllerDidSelectRow(_ repositoryListViewController: RepositoryListViewController) {
        delegate?.repositoryListViewCoordinatorDidSelectRow(self)
    }
}

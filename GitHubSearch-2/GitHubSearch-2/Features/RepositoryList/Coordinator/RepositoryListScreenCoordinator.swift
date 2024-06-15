//
//  RepositoryListScreenCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import GHSModels
import UIKit

protocol RepositoryListViewCoordinatorDelegate: AnyObject {
    func repositoryListViewCoordinator(_ coordinator: RepositoryListViewCoordinator, didSelect item: Item)
}

final class RepositoryListViewCoordinator: Coordinator {
    weak var delegate: RepositoryListViewCoordinatorDelegate?

    override func start() {
        let viewController = makeRepositoryListViewController()

        navigationController.pushViewController(viewController, animated: true)
    }

    private func makeRepositoryListViewController() -> RepositoryListViewController {
        let viewModel = RepositoryListViewModel()
        let viewController = RepositoryListViewController(viewModel: viewModel)

        viewController.delegate = self

        return viewController
    }
}

extension RepositoryListViewCoordinator: RepositoryListViewControllerDelegate {
    func repositoryListViewController(_ repositoryListViewController: RepositoryListViewController, didSelect item: Item) {
        delegate?.repositoryListViewCoordinator(self, didSelect: item)
    }
}

//
//  RepositoryDetailCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 27/05/2024.
//

import Foundation
import SafariServices

protocol RepositoryDetailCoordinatorDelegate: AnyObject {
    func repositoryDetailCoordinatorDidFinish(_ coordinator: Coordinator)
}

final class RepositoryDetailCoordinator: Coordinator {
    public weak var delegate: RepositoryDetailCoordinatorDelegate?

    private let item: Item

    init(navigationController: UINavigationController, item: Item) {
        self.item = item

        super.init(navigationController: navigationController)
    }

    override func start() {
        guard let htmlUrl = item.htmlUrl else {
            return
        }

        let viewController = SFSafariViewController(url: htmlUrl)
        viewController.delegate = self

        navigationController.present(viewController, animated: true)
    }
}

extension RepositoryDetailCoordinator: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        delegate?.repositoryDetailCoordinatorDidFinish(self)
    }
}

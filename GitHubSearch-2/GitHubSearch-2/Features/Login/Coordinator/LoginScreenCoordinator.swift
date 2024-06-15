//
//  LoginScreenCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 05/06/2024.
//

import Foundation

protocol LoginScreenCoordinatorDelegate: AnyObject {
    func loginScreenCoordinatorSignInTapped(_ loginScreenCoordinator: LoginScreenCoordinator)
}

final class LoginScreenCoordinator: Coordinator {
    weak var delegate: LoginScreenCoordinatorDelegate?

    override func start() {
        let viewController = makeLoginScreenViewController()
        viewController.delegate = self

        navigationController.pushViewController(viewController, animated: true)
    }

    private func makeLoginScreenViewController() -> LoginScreenViewController {
        let viewModel = LoginScreenViewModel()
        let viewController = LoginScreenViewController(viewModel: viewModel)
        return viewController
    }
}

extension LoginScreenCoordinator: LoginScreenViewControllerDelegate {
    func loginScreenViewControllerSignInTapped(_ loginScreenViewController: LoginScreenViewController) {
        delegate?.loginScreenCoordinatorSignInTapped(self)
    }
}

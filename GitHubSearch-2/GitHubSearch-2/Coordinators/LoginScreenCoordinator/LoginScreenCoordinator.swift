//
//  LoginScreenCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 05/06/2024.
//

import Foundation
import GHSLoginFeature
import Inject

protocol LoginScreenCoordinatorDelegate: AnyObject {
    func loginScreenCoordinatorSignInTapped(_ loginScreenCoordinator: LoginScreenCoordinator)
}

final class LoginScreenCoordinator: Coordinator {
    weak var delegate: LoginScreenCoordinatorDelegate?

    override func start() {
        let viewController = Inject.ViewControllerHost(self.makeLoginScreenViewController())
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
    func loginScreenViewControllerAddAccountTapped(_: LoginScreenViewController) {}

    func loginScreenViewControllerSignInTapped(_: LoginScreenViewController) {
        delegate?.loginScreenCoordinatorSignInTapped(self)
    }
}

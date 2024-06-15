//
//  AuthenticationInputViewController.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 13/06/2024.
//

import Foundation
import GHSCoreUI

protocol AuthenticationInputViewControllerDelegate: AnyObject {
    func loginInputViewModelDidLoginButtonTapped(_ authenticationInputViewController: AuthenticationInputViewController)
}

final class AuthenticationInputViewController: BasicViewController {
    weak var delegate: AuthenticationInputViewControllerDelegate?

    let viewModel: AuthenticationInputViewModel

    init(viewModel: AuthenticationInputViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = AuthenticationInputView(viewModel: viewModel)
    }

    override func viewDidLoad() {
        viewModel.delegate = self
    }
}

extension AuthenticationInputViewController: AuthenticationInputViewModelDelegate {
    func authenticationInputViewModelDidLoginButtonTapped(_: AuthenticationInputViewModel) {
        delegate?.loginInputViewModelDidLoginButtonTapped(self)
    }
}

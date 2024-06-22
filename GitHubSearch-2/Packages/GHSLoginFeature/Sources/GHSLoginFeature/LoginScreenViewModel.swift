//
//  LoginScreenViewModel.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 06/06/2024.
//

import CocoaLumberjackSwift
import Foundation

protocol LoginScreenViewModelDelegate: AnyObject {
    func loginScreenViewModelDidTapAddAccountButton(_ loginViewModel: LoginScreenViewModel)
}

public final class LoginScreenViewModel {
    weak var delegate: LoginScreenViewModelDelegate?

    var authButtonsViewModels =
        [
            AuthenticationButtonViewModelFactory.createViewModel(type: .email),
            AuthenticationButtonViewModelFactory.createViewModel(type: .apple),
            AuthenticationButtonViewModelFactory.createViewModel(type: .facebook),
            AuthenticationButtonViewModelFactory.createViewModel(type: .google),
        ]

    @objc func addAccountButtonTapped() {
        DDLogInfo("User did tap add account button")
        delegate?.loginScreenViewModelDidTapAddAccountButton(self)
    }

    @objc func didTapAuthenticationButton(_ button: AuthenticationButton) {
        guard let type = button.type else {
            return
        }
        button.viewModel.buttonDidTap?(type)
    }

    public init() {}
}

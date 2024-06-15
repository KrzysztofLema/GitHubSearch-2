//
//  LoginScreenViewController.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 05/06/2024.
//

import Foundation
import GHSCoreUI
import GHSModels

public protocol LoginScreenViewControllerDelegate: AnyObject {
    func loginScreenViewControllerSignInTapped(_ loginScreenViewController: LoginScreenViewController)
    func loginScreenViewControllerAddAccountTapped(_ loginScreenViewController: LoginScreenViewController)
}

public final class LoginScreenViewController: BasicViewController {
    public weak var delegate: LoginScreenViewControllerDelegate?

    private let viewModel: LoginScreenViewModel

    let authenticationInputViewModel = AuthenticationInputViewModel()

    private lazy var loginInputViewController = AuthenticationInputViewController(viewModel: authenticationInputViewModel)

    public init(viewModel: LoginScreenViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self

        loginInputViewController.delegate = self
        addChild(loginInputViewController)
        loginInputViewController.didMove(toParent: self)
    }

    override public func loadView() {
        view = LoginScreenView(viewModel: viewModel, loginInputView: loginInputViewController.view)
    }
}

extension LoginScreenViewController: LoginScreenViewModelDelegate {
    func loginScreenViewModelDidTapAddAccountButton(_: LoginScreenViewModel) {
        authenticationInputViewModel.viewType.toggle()
    }
}

extension LoginScreenViewController: AuthenticationInputViewControllerDelegate {
    func loginInputViewModelDidLoginButtonTapped(_: AuthenticationInputViewController) {
        delegate?.loginScreenViewControllerSignInTapped(self)
    }
}

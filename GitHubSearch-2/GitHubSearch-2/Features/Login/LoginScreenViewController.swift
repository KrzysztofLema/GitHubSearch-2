//
//  LoginScreenViewController.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 05/06/2024.
//

import Foundation

protocol LoginScreenViewControllerDelegate: AnyObject {
    func loginScreenViewControllerSignInTapped(_ loginScreenViewController: LoginScreenViewController)
}

final class LoginScreenViewController: BasicViewController {
    weak var delegate: LoginScreenViewControllerDelegate?

    private let viewModel: LoginScreenViewModel

    init(viewModel: LoginScreenViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

    override func loadView() {
        view = LoginScreenView(viewModel: viewModel)
    }
}

extension LoginScreenViewController: LoginScreenViewModelDelegate {
    func loginScreenViewModelDidTapSingInButton(_ loginViewModel: LoginScreenViewModel) {
        delegate?.loginScreenViewControllerSignInTapped(self)
    }
}

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

    @objc func addAccountButtonTapped() {
        DDLogInfo("User did tap add account button")
        delegate?.loginScreenViewModelDidTapAddAccountButton(self)
    }

    public init() {}
}

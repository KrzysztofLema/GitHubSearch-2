//
//  AuthenticationInputViewModel.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 13/06/2024.
//

// import CocoaLumberjackSwift
import Combine
import Foundation
import GHSDependecyInjection
import GHSModels

protocol AuthenticationInputViewModelDelegate: AnyObject {
    func authenticationInputViewModelDidLoginButtonTapped(_ authenticationInputViewModel: AuthenticationInputViewModel)
}

final class AuthenticationInputViewModel {
    @Injected(\.authenticationService) var authenticationService: AuthenticationServiceType

    @Published var viewType: AuthenticationInputViewType = .login

    weak var delegate: AuthenticationInputViewModelDelegate?

    var email = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    var isPasswordMatching: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $confirmPassword)
            .map { password, confirmPassword in
                !password.isEmpty && password == confirmPassword
            }
            .eraseToAnyPublisher()
    }

    init() {
        authenticationService.delegate = self
    }

    private func logIn() {
        authenticationService.signIn(with: email, password: password)
    }

    private func addUser() {
        authenticationService.addUser(with: email, password: password)
    }

    @objc func authenticationButtonTapped() {
        switch viewType {
        case .login:
            logIn()
        case .addUser:
            addUser()
        }
    }
}

extension AuthenticationInputViewModel: AuthenticationServiceDelegate {
    func authServiceUserDidLogIn() {
//        DDLogInfo("Auth service did log in")
        delegate?.authenticationInputViewModelDidLoginButtonTapped(self)
    }

    func authService(didOccurError _: Error) {}
}

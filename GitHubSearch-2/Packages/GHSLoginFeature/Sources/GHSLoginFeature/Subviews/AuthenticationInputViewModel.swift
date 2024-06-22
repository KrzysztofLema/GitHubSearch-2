//
//  AuthenticationInputViewModel.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 13/06/2024.
//

import Combine
import Foundation
import GHSDependecyInjection
import GHSModels

final class AuthenticationInputViewModel {
    @Published var viewType: AuthenticationInputViewType = .login
    @Published var email = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    var isPasswordMatching: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $confirmPassword)
            .map { password, confirmPassword in
                !password.isEmpty && password == confirmPassword
            }
            .eraseToAnyPublisher()
    }
}

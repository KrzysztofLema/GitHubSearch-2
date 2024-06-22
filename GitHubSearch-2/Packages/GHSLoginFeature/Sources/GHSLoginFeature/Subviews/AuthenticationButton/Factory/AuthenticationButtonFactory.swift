//
//  AuthenticationButtonFactory.swift
//
//
//  Created by Krzysztof Lema on 22/06/2024.
//

import Foundation
import GHSCoreUI
import GHSModels
import UIKit

protocol AuthenticationButtonViewModelFactoryType {
    static func createViewModel(type: AuthenticationButtonType) -> AuthenticationButtonViewModel
}

final class AuthenticationButtonViewModelFactory: AuthenticationButtonViewModelFactoryType {
    static func createViewModel(type: AuthenticationButtonType) -> AuthenticationButtonViewModel {
        switch type {
        case .email:
            return EmailAuthenticationButtonViewModelFactory().create()
        case .apple:
            return AppleAuthenticationButtonViewModelFactory().create()
        case .google:
            return GoogleAuthenticationButtonViewModelFactory().create()
        case .facebook:
            return FacebookAuthenticationButtonViewModelFactory().create()
        }
    }
}

protocol ViewModelFactoryType {
    func create() -> AuthenticationButtonViewModel
}

private class EmailAuthenticationButtonViewModelFactory: ViewModelFactoryType {
    func create() -> AuthenticationButtonViewModel {
        AuthenticationButtonViewModel(
            title: "Email",
            isEnable: true,
            type: .email,
            baseBackgroundColor: Color.Authentication.emailButtonBaseBackgroundColor,
            backgroundColor: Color.Authentication.emailButtonBackgroundColor
        )
    }
}

private class AppleAuthenticationButtonViewModelFactory: ViewModelFactoryType {
    func create() -> AuthenticationButtonViewModel {
        AuthenticationButtonViewModel(
            title: "Apple",
            isEnable: true,
            type: .apple,
            image: UIImage(named: "apple_login"),
            baseBackgroundColor: Color.Authentication.appleButtonBaseBackgroundColor,
            backgroundColor: Color.Authentication.appleButtonBackgroundColor
        )
    }
}

private class GoogleAuthenticationButtonViewModelFactory: ViewModelFactoryType {
    func create() -> AuthenticationButtonViewModel {
        AuthenticationButtonViewModel(
            title: "Google",
            isEnable: true,
            type: .google,
            image: UIImage(named: "google_login"),
            baseBackgroundColor: Color.Authentication.googleButtonBaseBackgroundColor,
            backgroundColor: Color.Authentication.googleButtonBackgroundColor
        )
    }
}

private class FacebookAuthenticationButtonViewModelFactory: ViewModelFactoryType {
    func create() -> AuthenticationButtonViewModel {
        AuthenticationButtonViewModel(
            title: "Facebook",
            isEnable: true,
            type: .facebook,
            image: UIImage(named: "facebook_login"),
            baseBackgroundColor: Color.Authentication.appleButtonBaseBackgroundColor,
            backgroundColor: Color.Authentication.facebookButtonBackgroundColor
        )
    }
}

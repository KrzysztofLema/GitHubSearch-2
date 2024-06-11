//
//  LoginViewModel.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 06/06/2024.
//

import CocoaLumberjackSwift
import Foundation

protocol LoginScreenViewModelDelegate: AnyObject {
    func loginScreenViewModelDidTapSingInButton(_ loginViewModel: LoginScreenViewModel)
}

final class LoginScreenViewModel {
    
    @Injected(\.authenticationService) var authenticationService: AuthenticationServiceType
    
    weak var delegate: LoginScreenViewModelDelegate?
        
    var email = ""
    var password = ""
    
    init() {
        authenticationService.delegate = self
    }
    
    func logIn() {
        authenticationService.signIn(with: email, password: password)
    }
}

extension LoginScreenViewModel: AuthenticationServiceDelegate {    
    func authServiceUserDidLogIn() {
        DDLogInfo("Auth service did log in")
        delegate?.loginScreenViewModelDidTapSingInButton(self)
    }
    
    func authService(didOccurError error: Error) {
        
    }
}

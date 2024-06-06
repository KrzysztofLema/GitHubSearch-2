//
//  LoginViewModel.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 06/06/2024.
//

import Foundation
import CocoaLumberjackSwift

protocol LoginScreenViewModelDelegate: AnyObject {
    func loginScreenViewModelDidTapSingInButton(_ loginViewModel: LoginScreenViewModel)
}

final class LoginScreenViewModel {
    
    public var email = ""
    public var password = ""
}

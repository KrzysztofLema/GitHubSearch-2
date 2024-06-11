//
//  AuthenticationService.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 09/06/2024.
//

import CocoaLumberjackSwift
import FirebaseAuth
import Foundation

protocol AuthenticationServiceDelegate: AnyObject {
    func authServiceUserDidLogIn()
    func authService(didOccurError error: Error)
}

protocol AuthenticationServiceType {
    var delegate: AuthenticationServiceDelegate? { get set }
    
    func signIn(with email: String, password: String)
}

public class AuthenticationService: AuthenticationServiceType {
    
    @Injected(\.firebaseProvider) private var firebaseProvider: FirebaseProviderType
    
    weak var delegate: AuthenticationServiceDelegate?
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
       registerAuthStateHandler()
    }
    
    public func signIn(with email: String, password: String) {
        firebaseProvider.auth.signIn(
            withEmail: email,
            password: password
        ) { [weak self] result, error in
            guard let self else {
                return
            }
            if let error = error as? NSError {
                DDLogInfo("\(error.localizedDescription)")
                delegate?.authService(didOccurError: error)
            } else {
                DDLogInfo("User did sign in: \(result)")
                delegate?.authServiceUserDidLogIn()
            }
        }
    }
    
    private func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = firebaseProvider.auth.addStateDidChangeListener { auth, user in
                
            }
        }
    }
}

struct AuthenticationServiceKey: InjectionKey {
    static var currentValue: AuthenticationServiceType = AuthenticationService()
}

extension InjectedValues {
    var authenticationService: AuthenticationServiceType {
        get { Self[AuthenticationServiceKey.self] }
        set { Self[AuthenticationServiceKey.self] = newValue }
    }
}

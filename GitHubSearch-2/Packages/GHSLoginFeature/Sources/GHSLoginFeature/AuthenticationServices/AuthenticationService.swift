//
//  AuthenticationService.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 09/06/2024.
//

import AuthenticationServices
import CocoaLumberjackSwift
import FirebaseAuth
import Foundation
import GHSDependecyInjection

public protocol AuthenticationServiceDelegate: AnyObject {
    func authServiceUserDidLogIn()
    func authService(didOccurError error: Error)
}

public protocol AuthenticationServiceType {
    var delegate: AuthenticationServiceDelegate? { get set }

    func signIn(with email: String, password: String)
    func signInWithApple()
    func signOut()
    func createUser(with email: String, password: String)
}

public class AuthenticationService: NSObject, AuthenticationServiceType {
    @Injected(\.firebaseProvider) private var firebaseProvider: FirebaseProviderType

    public weak var delegate: AuthenticationServiceDelegate?

    private var currentNonce: String?
    private var authStateHandler: AuthStateDidChangeListenerHandle?

    override init() {
        super.init()
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
                delegate?.authService(didOccurError: error)
            } else {
                DDLogInfo("User did sign in: \(result)")
                delegate?.authServiceUserDidLogIn()
            }
        }
    }

    public func signInWithApple() {
        let request = createAppleIdRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])

        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self

        authorizationController.performRequests()
    }

    public func performExistingAccountSetupFlow() {
        let requests = [
            ASAuthorizationAppleIDProvider().createRequest(),
            ASAuthorizationPasswordProvider().createRequest(),
        ]

        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self

        authorizationController.performRequests()
    }

    public func signOut() {
        do {
            try firebaseProvider.auth.signOut()
        } catch {
            DDLogInfo("Error while trying to sign out: \(error.localizedDescription)")
            delegate?.authService(didOccurError: error)
        }
    }

    private func createAppleIdRequest() -> ASAuthorizationRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()

        request.requestedScopes = [.email, .fullName]

        do {
            let nonce = try CryptoUtils.randomNonceString()
            currentNonce = nonce
            request.nonce = CryptoUtils.sha256(nonce)
        } catch {
            print("Error when creating a nonce: \(error.localizedDescription)")
        }

        return request
    }

    public func createUser(with email: String, password: String) {
        firebaseProvider.auth.createUser(withEmail: email, password: password) { [weak self] result, error in
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
            authStateHandler = firebaseProvider.auth.addStateDidChangeListener { [weak self] _, _ in
            }
        }
    }
}

extension AuthenticationService: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first ?? UIWindow()
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            guard let nonce = currentNonce else {
                fatalError("Invalid state: a login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identify token.")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialise token string from data: \(appleIDToken.debugDescription)")
                return
            }

            let credential = OAuthProvider.appleCredential(
                withIDToken: idTokenString,
                rawNonce: nonce,
                fullName: appleIDCredential.fullName
            )

            do {
                firebaseProvider.auth.signIn(with: credential) { [weak self] result, error in
                    guard let self else {
                        return
                    }
                    if let error = error as? NSError {
                        delegate?.authService(didOccurError: error)
                    } else {
                        DDLogInfo("User did sign in: \(result)")
                        delegate?.authServiceUserDidLogIn()
                    }
                }
            } catch {
                print("Error authenticating: \(error.localizedDescription)")
                return
            }
        default:
            break
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        delegate?.authService(didOccurError: error)
    }
}

struct AuthenticationServiceKey: InjectionKey {
    static var currentValue: AuthenticationServiceType = AuthenticationService()
}

extension InjectedValues {
    public var authenticationService: AuthenticationServiceType {
        get { Self[AuthenticationServiceKey.self] }
        set { Self[AuthenticationServiceKey.self] = newValue }
    }
}

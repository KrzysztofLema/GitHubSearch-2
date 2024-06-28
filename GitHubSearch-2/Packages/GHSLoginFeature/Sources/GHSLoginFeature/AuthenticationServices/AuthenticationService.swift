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
    func signInWithFacebook()
    func signInWithGoogle()
    func signOut()
    func createUser(with email: String, password: String)
}

public class AuthenticationService: AuthenticationServiceType {
    @Injected(\.firebaseProvider) private var firebaseProvider: FirebaseProviderType

    @Injected(\.appleAuthenticationService) private var appleAuthenticationService: AppleAuthenticationServiceType
    @Injected(\.emailAuthenticationService) private var emailAuthenticationService: EmailAuthenticationServiceType
    @Injected(\.googleAuthenticationService) private var googleAuthenticationService: GoogleAuthenticationServiceType
    @Injected(\.facebookAuthenticationService) private var facebookAuthenticationService: FacebookAuthenticationServiceType

    public weak var delegate: AuthenticationServiceDelegate?

    private var authStateHandler: AuthStateDidChangeListenerHandle?

    init() {
        registerAuthStateHandler()

        appleAuthenticationService.delegate = self
        emailAuthenticationService.delegate = self
        facebookAuthenticationService.delegate = self
        googleAuthenticationService.delegate = self
    }

    public func signInWithApple() {
        appleAuthenticationService.signInWithApple()
    }

    public func signIn(with email: String, password: String) {
        emailAuthenticationService.signIn(with: email, password: password)
    }

    public func signInWithFacebook() {
        facebookAuthenticationService.signInWithFacebook()
    }

    public func signInWithGoogle() {
        googleAuthenticationService.signInWithGoogle()
    }

    public func createUser(with email: String, password: String) {
        emailAuthenticationService.createUser(with: email, password: password)
    }

    public func signOut() {
        do {
            try firebaseProvider.auth.signOut()
        } catch {
            DDLogInfo("Error while trying to sign out: \(error.localizedDescription)")
            delegate?.authService(didOccurError: error)
        }
    }

    private func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = firebaseProvider.auth.addStateDidChangeListener { [weak self] _, _ in
            }
        }
    }
}

extension AuthenticationService: AppleAuthenticationServiceDelegate {
    func appleAuthenticationServiceUserDidLogIn() {
        delegate?.authServiceUserDidLogIn()
    }

    func appleAuthenticationService(didOccurError error: any Error) {
        delegate?.authService(didOccurError: error)
    }
}

extension AuthenticationService: EmailAuthenticationServiceDelegate {
    func emailAuthenticationServiceUserDidLogIn() {
        delegate?.authServiceUserDidLogIn()
    }

    func emailAuthenticationService(didOccurError error: any Error) {
        delegate?.authService(didOccurError: error)
    }
}

extension AuthenticationService: GoogleAuthenticationServiceDelegate {
    public func googleAuthenticationServiceUserDidLogIn() {
        delegate?.authServiceUserDidLogIn()
    }

    public func googleAuthenticationService(didOccurError error: any Error) {
        delegate?.authService(didOccurError: error)
    }
}

extension AuthenticationService: FacebookAuthenticationServiceDelegate {
    func facebookAuthenticationServiceDidCancel() {
        DDLogInfo("Facebook service did cancel")
    }

    func facebookAuthenticationServiceUserDidLogIn() {
        delegate?.authServiceUserDidLogIn()
    }

    func facebookAuthenticationService(didOccurError error: any Error) {
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

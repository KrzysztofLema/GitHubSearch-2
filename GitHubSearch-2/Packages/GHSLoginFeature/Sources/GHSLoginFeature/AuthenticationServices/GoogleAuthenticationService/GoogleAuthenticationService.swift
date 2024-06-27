import FirebaseAuth
import FirebaseCore
import Foundation
import GHSDependecyInjection
import GoogleSignIn

protocol GoogleAuthenticationServiceDelegate: AnyObject {
    func googleAuthenticationServiceUserDidLogIn()
    func googleAuthenticationService(didOccurError error: Error)
}

protocol GoogleAuthenticationServiceType {
    func sighInWithGoogle()

    var delegate: GoogleAuthenticationServiceDelegate? { get set }
}

final class GoogleAuthenticationService: GoogleAuthenticationServiceType {
    @Injected(\.firebaseProvider) private var firebaseProvider: FirebaseProviderType

    weak var delegate: GoogleAuthenticationServiceDelegate?

    public func sighInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            return
        }

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
            guard error == nil else {
                delegate?.googleAuthenticationService(didOccurError: error!)
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            authenticationSignInWith(credential)
        }
    }

    private func authenticationSignInWith(_ credential: AuthCredential) {
        firebaseProvider.auth.signIn(with: credential) { [weak self] _, error in
            guard let self = self else {
                return
            }

            if let error = error {
                self.delegate?.googleAuthenticationService(didOccurError: error)
            } else {
                self.delegate?.googleAuthenticationServiceUserDidLogIn()
            }
        }
    }
}

struct GoogleAuthenticationServiceKey: InjectionKey {
    static var currentValue: GoogleAuthenticationServiceType = GoogleAuthenticationService()
}

extension InjectedValues {
    var googleAuthenticationService: GoogleAuthenticationServiceType {
        get { Self[GoogleAuthenticationServiceKey.self] }
        set { Self[GoogleAuthenticationServiceKey.self] = newValue }
    }
}

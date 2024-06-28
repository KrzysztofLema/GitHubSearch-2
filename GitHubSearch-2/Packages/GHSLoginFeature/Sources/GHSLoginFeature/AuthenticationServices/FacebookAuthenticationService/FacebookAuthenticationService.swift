import CocoaLumberjackSwift
import FacebookCore
import FacebookLogin
import FirebaseAuth
import Foundation
import GHSDependecyInjection

protocol FacebookAuthenticationServiceDelegate: AnyObject {
    func facebookAuthenticationService(didOccurError error: Error)
    func facebookAuthenticationServiceUserDidLogIn()
    func facebookAuthenticationServiceDidCancel()
}

protocol FacebookAuthenticationServiceType {
    func signInWithFacebook()

    var delegate: FacebookAuthenticationServiceDelegate? { get set }
}

final class FacebookAuthenticationService: FacebookAuthenticationServiceType {
    @Injected(\.firebaseProvider) private var firebaseProvider: FirebaseProviderType

    weak var delegate: FacebookAuthenticationServiceDelegate?

    enum Constants {
        static let publicProfilePermission = "public_profile"
        static let emailPermission = "email"
        static let facebookProviderID = "facebook.com"
    }

    private var currentNonce: String?

    func signInWithFacebook() {
        do {
            let nonce = try CryptoUtils.randomNonceString()
            currentNonce = nonce
        } catch {
            DDLogError("Can't create random nonce.")
            delegate?.facebookAuthenticationService(didOccurError: error)
        }

        let sha256Nonce = CryptoUtils.sha256(currentNonce ?? "")

        guard let configuration = LoginConfiguration(
            permissions: [.publicProfile, .email],
            tracking: .limited,
            nonce: sha256Nonce
        )
        else {
            return
        }

        let manager = LoginManager()
        manager.logOut()

        manager.logIn(configuration: configuration) { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .cancelled:
                break
            case .failed(let error):
                self.delegate?.facebookAuthenticationService(didOccurError: error)
            case .success:
                self.loginFirebase(currentNonce: self.currentNonce)
            }
        }
    }

    func loginFirebase(currentNonce: String?) {
        guard let token = AuthenticationToken.current else { return }
        guard let profile = Profile.current else { return }
        guard let currentNonce else { return }

        if let email = profile.email, let name = profile.name {
            DDLogInfo("FB Login OK, Name = \(name), email = \(email)")
        }

        let tokenString = token.tokenString
        let credential = OAuthProvider.credential(withProviderID: Constants.facebookProviderID, idToken: tokenString, rawNonce: currentNonce)

        Auth.auth().signIn(with: credential, completion: { result, error in
            if let error = error {
                DDLogError("Auth signIn Error: \(error.localizedDescription)")
            }

            guard let result = result else {
                DDLogError("Auth signIn result = nil")
                return
            }

            DDLogInfo("Auth user: \(result.user.displayName ?? "noName")")

            self.delegate?.facebookAuthenticationServiceUserDidLogIn()
        })
    }
}

struct FacebookAuthenticationServiceKey: InjectionKey {
    static var currentValue: FacebookAuthenticationServiceType = FacebookAuthenticationService()
}

extension InjectedValues {
    var facebookAuthenticationService: FacebookAuthenticationServiceType {
        get { Self[FacebookAuthenticationServiceKey.self] }
        set { Self[FacebookAuthenticationServiceKey.self] = newValue }
    }
}

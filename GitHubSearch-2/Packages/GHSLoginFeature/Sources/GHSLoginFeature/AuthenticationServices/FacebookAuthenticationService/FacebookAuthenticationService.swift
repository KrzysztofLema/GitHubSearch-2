import FacebookCore
import FacebookLogin
import Foundation
import GHSDependecyInjection
import FirebaseAuth

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
    }
    
    private var currentNonce: String?
    
    func signInWithFacebook() {
        do {
            let nonce = try CryptoUtils.randomNonceString()
            currentNonce = nonce
        } catch {
            print(error)
        }
        
        
        guard let configuration = LoginConfiguration(
            permissions:[.publicProfile, .email],
            tracking: .limited,
            nonce: CryptoUtils.sha256(currentNonce!)
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
                break
            case .success:
                self.loginFirebase(currentNonce: self.currentNonce!)
                break
            @unknown default:
                break
            }
        }
            
    }

    func loginFirebase(currentNonce: String) {
        guard let token = AuthenticationToken.current else { return }
        
        guard let profile = Profile.current else { return }
        if let email = profile.email, let name = profile.name {
            print("FB Login OK, Name = \(name), email = \(email)")
        }
        
        let tokenString = token.tokenString
        let credential = OAuthProvider.credential(withProviderID: "facebook.com", idToken: tokenString, rawNonce: currentNonce)
        Auth.auth().signIn(with: credential, completion: {result, error in
            if let error = error {
                print("Auth signIn Error: " + error.localizedDescription)
            }
            
            guard let result = result else {
                print("Auth signIn result = nil")
                return
            }
            
            print("Auth user: \(result.user.displayName ?? "noName")" )
            
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

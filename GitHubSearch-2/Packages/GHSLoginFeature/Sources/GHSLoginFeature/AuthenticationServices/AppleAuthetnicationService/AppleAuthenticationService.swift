import AuthenticationServices
import CocoaLumberjackSwift
import FirebaseAuth
import Foundation
import GHSDependecyInjection

protocol AppleAuthenticationServiceType {
    func signInWithApple()

    var delegate: AppleAuthenticationServiceDelegate? { get set }
}

protocol AppleAuthenticationServiceDelegate: AnyObject {
    func appleAuthenticationServiceUserDidLogIn()
    func appleAuthenticationService(didOccurError error: Error)
}

final class AppleAuthenticationService: NSObject, AppleAuthenticationServiceType {
    @Injected(\.firebaseProvider) private var firebaseProvider: FirebaseProviderType

    weak var delegate: AppleAuthenticationServiceDelegate?

    private var currentNonce: String?

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
}

struct AppleAuthenticationServiceKey: InjectionKey {
    static var currentValue: AppleAuthenticationServiceType = AppleAuthenticationService()
}

extension InjectedValues {
    var appleAuthenticationService: AppleAuthenticationServiceType {
        get { Self[AppleAuthenticationServiceKey.self] }
        set { Self[AppleAuthenticationServiceKey.self] = newValue }
    }
}

extension AppleAuthenticationService: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
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
                DDLogInfo("Unable to fetch identify token.")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                DDLogInfo("Unable to serialise token string from data: \(appleIDToken.debugDescription)")
                return
            }

            let credential = OAuthProvider.appleCredential(
                withIDToken: idTokenString,
                rawNonce: nonce,
                fullName: appleIDCredential.fullName
            )

            firebaseProvider.auth.signIn(with: credential) { [weak self] result, error in
                guard let self else {
                    return
                }
                if let error = error as? NSError {
                    delegate?.appleAuthenticationService(didOccurError: error)
                } else {
                    DDLogInfo("User did sign in: \(result)")
                    delegate?.appleAuthenticationServiceUserDidLogIn()
                }
            }
        default:
            break
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        delegate?.appleAuthenticationService(didOccurError: error)
    }
}

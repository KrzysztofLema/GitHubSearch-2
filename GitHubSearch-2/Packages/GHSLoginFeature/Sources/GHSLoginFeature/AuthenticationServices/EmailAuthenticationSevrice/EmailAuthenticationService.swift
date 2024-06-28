import CocoaLumberjackSwift
import Foundation
import GHSDependecyInjection

protocol EmailAuthenticationServiceDelegate: AnyObject {
    func emailAuthenticationServiceUserDidLogIn()
    func emailAuthenticationService(didOccurError error: Error)
}

protocol EmailAuthenticationServiceType {
    func signIn(with email: String, password: String)
    func createUser(with email: String, password: String)

    var delegate: EmailAuthenticationServiceDelegate? { get set }
}

final class EmailAuthenticationService: EmailAuthenticationServiceType {
    @Injected(\.firebaseProvider) private var firebaseProvider: FirebaseProviderType

    weak var delegate: EmailAuthenticationServiceDelegate?

    public func signIn(with email: String, password: String) {
        firebaseProvider.auth.signIn(
            withEmail: email,
            password: password
        ) { [weak self] result, error in
            guard let self else {
                return
            }

            if let error = error as? NSError {
                self.delegate?.emailAuthenticationService(didOccurError: error)
            } else {
                DDLogInfo("User did sign in: \(result?.user)")
                self.delegate?.emailAuthenticationServiceUserDidLogIn()
            }
        }
    }

    public func createUser(with email: String, password: String) {
        firebaseProvider.auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self else {
                return
            }

            if let error = error as? NSError {
                DDLogInfo("\(error.localizedDescription)")
                delegate?.emailAuthenticationService(didOccurError: error)
            } else {
                DDLogInfo("User did sign in: \(result?.user)")
                delegate?.emailAuthenticationServiceUserDidLogIn()
            }
        }
    }
}

struct EmailAuthenticationServiceKey: InjectionKey {
    static var currentValue: EmailAuthenticationServiceType = EmailAuthenticationService()
}

extension InjectedValues {
    var emailAuthenticationService: EmailAuthenticationServiceType {
        get { Self[EmailAuthenticationServiceKey.self] }
        set { Self[EmailAuthenticationServiceKey.self] = newValue }
    }
}

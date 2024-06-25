import CocoaLumberjackSwift
import FirebaseAuth
import Foundation
import GHSDependecyInjection

protocol FirebaseProviderType {
    var auth: Auth { get }
}

final class FirebaseProvider: FirebaseProviderType {
    public var useEmulator: Bool {
        let value = UserDefaults.standard.bool(forKey: "useEmulator")
        DDLogInfo("Using the emulator: \(value == true ? "YES" : "NO")")
        return value
    }
    


    public var auth: Auth {
        var environment = ""
        if useEmulator {
            let host = "localhost"
            let port = 9099
            environment = "to use the local emulator on \(host):\(port)"
            Auth.auth().useEmulator(withHost: host, port: port)
        } else {
            environment = "to use the Firebase backend"
        }

        DDLogInfo("Configuring Firebase Auth \(environment).")
        return Auth.auth()
    }
}

struct FirebaseProviderKey: InjectionKey {
    static var currentValue: FirebaseProviderType = FirebaseProvider()
}

extension InjectedValues {
    var firebaseProvider: FirebaseProviderType {
        get { Self[FirebaseProviderKey.self] }
        set { Self[FirebaseProviderKey.self] = newValue }
    }
}

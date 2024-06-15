//
//  SceneDelegate.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 17/05/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private let rootNavigationController = NavigationController()
    private lazy var appCoordinator = ApplicationCoordinator(navigationController: rootNavigationController)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        setupWindow(with: windowScene)

        DispatchQueue.main.async { [weak self] in
            self?.appCoordinator.start()
        }
    }
}

private extension SceneDelegate {
    func setupWindow(with windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}

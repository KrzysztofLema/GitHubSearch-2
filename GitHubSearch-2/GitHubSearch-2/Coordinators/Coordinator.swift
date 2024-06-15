//
//  Coordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import CocoaLumberjackSwift
import Foundation
import UIKit

class Coordinator: NSObject {
    public weak var viewController: UIViewController?
    public var didFinish: (() -> Void)?
    public var navigationController: UINavigationController
    public var parentCoordinator: Coordinator?

    private var childCoordinators = [Coordinator]()

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {}

    func addChild(_ child: Coordinator) {
        DDLogInfo("Child added to \(child)")
        child.didFinish = { [weak self] in
            self?.removeChild(child)
        }

        childCoordinators.append(child)
    }

    func removeChild(_ child: Coordinator) {
        if let index = childCoordinators.firstIndex(of: child) {
            child.removeAllChildCoordinators()
            child.didFinish = nil
            childCoordinators.remove(at: index)
            DDLogInfo("Child removed: \(child) from \(self)")
        } else {
            DDLogInfo("Couldn't remove child")
        }
    }

    func removeAllChildCoordinators() {
        for coordinator in childCoordinators {
            coordinator.didFinish = nil
            coordinator.removeAllChildCoordinators()
        }
        childCoordinators.removeAll()

        DDLogInfo("Removed all child coordinators")
    }
}

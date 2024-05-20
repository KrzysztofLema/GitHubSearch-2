//
//  ApplicationCoordinator.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 18/05/2024.
//

import Foundation

class ApplicationCoordinator: Coordinator {
    
    override func start() {
        startChild(for: .home, sourceCoordinator: self)
    }
    
    func startChild(for deepLink: DeepLink,
                    shouldReplaceRoot: Bool = false,
                    completion: (() -> Void)? = nil,
                    sourceCoordinator: Coordinator?) {
        guard let sourceCoordinator else {
            return
        }
        
        switch deepLink {
        case .home:
            sourceCoordinator.startHomeCoordinator()
        }
    }
}

enum DeepLink: Equatable {
    case home
}

extension Coordinator {
    func startHomeCoordinator() {
        let startHomeCoordinator = TabBarCoordinator(navigationController: navigationController)
        startHomeCoordinator.start()
        addChild(startHomeCoordinator)
    }
}

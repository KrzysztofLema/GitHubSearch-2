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
            startHomeCoordinator()
        case .repositoryDetail:
            startRepositoryDetailCoordinator()
        }
    }
}

enum DeepLink: Equatable {
    case home
    case repositoryDetail
}

extension ApplicationCoordinator {
    func startHomeCoordinator() {
        let startHomeCoordinator = TabBarCoordinator(navigationController: navigationController)
        startHomeCoordinator.delegate = self
        startHomeCoordinator.start()
        addChild(startHomeCoordinator)
    }
    
    func startRepositoryDetailCoordinator() {
        let startRepositoryDetailCoordinator = RepositoryDetailCoordinator(navigationController: navigationController)
        startRepositoryDetailCoordinator.start()
        addChild(startRepositoryDetailCoordinator)
    }
}

extension ApplicationCoordinator: TabBarCoordinatorDelegate {
    func repositoryListViewCoordinatorDidSelectRow(_ coordinator: TabBarCoordinator) {
        startChild(for: .repositoryDetail, sourceCoordinator: self)
    }
}

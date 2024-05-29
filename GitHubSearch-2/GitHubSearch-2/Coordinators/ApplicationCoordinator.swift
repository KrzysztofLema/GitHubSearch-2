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
        case let .repositoryDetail(item):
            startRepositoryDetailCoordinator(item: item)
        }
    }
}

enum DeepLink: Equatable {
    case home
    case repositoryDetail(item: Item)
}

extension ApplicationCoordinator {
    func startHomeCoordinator() {
        let startHomeCoordinator = TabBarCoordinator(navigationController: navigationController)
        startHomeCoordinator.delegate = self
        startHomeCoordinator.start()
        addChild(startHomeCoordinator)
    }
    
    func startRepositoryDetailCoordinator(item: Item) {
        let startRepositoryDetailCoordinator = RepositoryDetailCoordinator(navigationController: navigationController, item: item)
        startRepositoryDetailCoordinator.start()
        
        startRepositoryDetailCoordinator.delegate = self
        
        addChild(startRepositoryDetailCoordinator)
    }
}

extension ApplicationCoordinator: TabBarCoordinatorDelegate {
    func repositoryListViewCoordinator(_ coordinator: TabBarCoordinator, didSelect item: Item) {
        startChild(for: .repositoryDetail(item: item), sourceCoordinator: self)
    }
}

extension ApplicationCoordinator: RepositoryDetailCoordinatorDelegate {
    func repositoryDetailCoordinatorDidFinish(_ coordinator: Coordinator) {
        removeChild(coordinator)
    }
}

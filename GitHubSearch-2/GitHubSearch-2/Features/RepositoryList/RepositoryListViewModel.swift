//
//  MainViewModel.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 25/05/2024.
//

import Foundation
import Combine

final class RepositoryListViewModel {
    
    @Injected(\.searchService) var searchService: SearchServiceType
    
    @Published var searchInput: String = ""
    @Published public private(set) var searchResults: [Item] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchInput
            .sink(receiveValue: searchForGitHubRepositories(using:))
            .store(in: &cancellables)
    }
    
    func searchForGitHubRepositories(using input: String) {
        do {
            try self.searchService.search(with: input, page: 1, sortType: .forks, orderType: .desc)
                .receive(on: DispatchQueue.main)
                .map(\.items)
                .sink(receiveCompletion: { _ in
                }, receiveValue: {
                    self.update(searchResults: $0)
                })
                .store(in: &cancellables)
        } catch let error {
            
        }
    }
    
    private func update(searchResults: [Item]) {
        self.searchResults = searchResults
    }
}

//
//  RepositoryListViewModel.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 25/05/2024.
//

import Combine
import Foundation
import GHSDependecyInjection
import GHSModels

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

    private func searchForGitHubRepositories(using input: String) {
        do {
            try searchService.search(with: input, page: 1, sortType: .forks, orderType: .desc)
                .receive(on: DispatchQueue.main)
                .assertNoFailure()
                .map(\.items)
                .assign(to: \.searchResults, on: self)
                .store(in: &cancellables)
        } catch _ {}
    }

    private func update(with searchResults: [Item]) {
        self.searchResults = searchResults
    }
}

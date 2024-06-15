//
//  SearchService.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 20/05/2024.
//

import Combine
import Foundation
import GHSDtoModels
import GHSModels

final class SearchService: SearchServiceType {
    @Injected(\.requestManager) var requestManager: RequestManagerType

    func search(
        with keyword: String,
        page: Int,
        sortType: SortType? = .none,
        orderType: OrderType? = .none
    ) throws -> AnyPublisher<SearchResult, ServiceError> {
        try requestManager.perform(
            SearchRequest.search(
                keyword: keyword,
                sortType: sortType,
                page: page,
                orderType: orderType
            ),
            type: SearchResultResponseDTO.self
        )
        .mapError(ServiceError.networkError)
        .map(SearchResult.init)
        .eraseToAnyPublisher()
    }
}

struct SearchServiceKey: InjectionKey {
    static var currentValue: SearchServiceType = SearchService()
}

extension InjectedValues {
    var searchService: SearchServiceType {
        get { Self[SearchServiceKey.self] }
        set { Self[SearchServiceKey.self] = newValue }
    }
}

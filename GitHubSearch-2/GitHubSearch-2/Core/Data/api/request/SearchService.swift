//
//  SearchService.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 20/05/2024.
//

import Combine
import Foundation

final class SearchService: SearchServiceType {
    
    private let requestManager = RequestManager()
    
    func search(
        with keyword: String,
        sortType: SortType? = .none,
        page: Int,
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

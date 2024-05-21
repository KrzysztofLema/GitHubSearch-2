//
//  SearchServiceType.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 20/05/2024.
//

import Combine
import Foundation

protocol SearchServiceType {
    func search(with keyword: String, sortType: SortType?, page: Int, orderType: OrderType?) throws -> AnyPublisher<SearchResult, ServiceError>
}

//
//  APIConstants.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 20/05/2024.
//

import Foundation

enum APIConstants {
    static let apiQueueLabel = "api"

    static let host = "api.github.com"
    static let scheme = "https"
    static let searchRepositoryPath = "/search/repositories"

    static let pageSize = 15

    static let searchRepositoryParamKey = "q"
    static let pageNumberKey = "page"
    static let sortTypeKey = "sort"
    static let pageSizeKey = "per_page"
    static let orderTypeKey = "order"
}

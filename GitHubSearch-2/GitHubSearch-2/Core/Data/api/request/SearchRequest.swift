//
//  GitHubRequest.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 21/05/2024.
//

import Foundation

enum SearchRequest: RequestProtocol {
    
    case search(keyword: String, sortType: SortType?, page: Int, orderType: OrderType?)
    
    var path: String {
        APIConstants.searchRepositoryPath
    }
    
    var urlParams: [String : String?] {
        switch self {
        case let .search(keyword, sortType, page, orderType):
            var params = [
                APIConstants.searchRepositoryParamKey: keyword,
                APIConstants.pageNumberKey: String(page),
                APIConstants.pageSizeKey: String(APIConstants.pageSize)
            ]
            
            if let sortType {
                params[APIConstants.sortTypeKey] = sortType.rawValue
            }
            
            if let orderType {
                params[APIConstants.orderTypeKey] = orderType.rawValue
            }
            
            return params
        }
    }
    
    var requestType: RequestType {
        .GET
    }
}

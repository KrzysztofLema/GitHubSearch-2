//
//  NetworkError.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 20/05/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidServerResponse
    case invalidURL
    case notConnectedToInternet
    case networkError
    case dataParsingFailed
    case responseMissing
    case requestError
    
    var description: String {
        switch self {
        case .invalidServerResponse:
            return "Server returned invalid response."
        case .invalidURL:
            return "URL is invalid."
        case .notConnectedToInternet:
            return "Device is not connected to internet."
        case .networkError:
            return "There is problem with network connection."
        case .dataParsingFailed:
            return "Data parsing was incorrect."
        case .responseMissing:
            return "There is response missing." 
        case .requestError:
            return "Request Error"
        }
    }
}

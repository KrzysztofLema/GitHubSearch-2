//
//  ServiceError.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 21/05/2024.
//

import Foundation

public enum ServiceError: Error {
    case networkError(NetworkError)
}

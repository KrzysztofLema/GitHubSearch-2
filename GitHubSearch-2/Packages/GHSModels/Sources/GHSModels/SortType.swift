//
//  SortType.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 23/05/2024.
//

import Foundation

public enum SortType: String {
    case stars, forks, helpWantedIssues, updated

    public var rawValue: String {
        switch self {
        case .stars: return "stars"
        case .forks: return "forks"
        case .helpWantedIssues: return "help-wanted-issues"
        case .updated: return "updated"
        }
    }
}

//
//  Credentials.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 07/06/2024.
//

import Foundation

public struct Credentials {
    public let login: String
    public let password: String
    
    public init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}

//
//  AuthenticationInputViewType.swift
//
//
//  Created by Krzysztof Lema on 15/06/2024.
//

import Foundation

public enum AuthenticationInputViewType {
    case login
    case addUser

    public mutating func toggle() {
        if self == .login {
            self = .addUser
        } else {
            self = .login
        }
    }
}

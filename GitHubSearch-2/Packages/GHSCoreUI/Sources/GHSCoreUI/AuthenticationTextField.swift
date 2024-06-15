//
//  AuthenticationTextField.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 07/06/2024.
//

import UIKit

public final class AuthenticationTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Color.lightTrim
        textColor = Color.darkTextColor
        autocapitalizationType = .none
        autocorrectionType = .no
        clearButtonMode = .always
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupView(placeholderText: String) {
        placeholder = placeholderText
    }
}

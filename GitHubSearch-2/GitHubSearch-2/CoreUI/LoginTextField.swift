//
//  LoginTextField.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 07/06/2024.
//

import UIKit

final class LoginTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Color.lightTrim
        textColor = Color.darkTextColor
        autocapitalizationType = .none
        autocorrectionType = .no
        clearButtonMode = .always
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(placeholderText: String) {
        placeholder = placeholderText
    }
}

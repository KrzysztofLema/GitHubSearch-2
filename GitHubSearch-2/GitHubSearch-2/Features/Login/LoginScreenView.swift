//
//  LoginScreenView.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 05/06/2024.
//

import CocoaLumberjackSwift
import Combine
import TinyConstraints
import UIKit

protocol LoginScreenViewDelegate: AnyObject {
    func loginScreenViewSignInButtonTapped(_ loginViewModel: LoginScreenView)
}

final class LoginScreenView: BasicView {
    weak var delegate: LoginScreenViewDelegate?

    private let viewModel: LoginScreenViewModel
    private let contentView = UIView()
    private let logoImageView = UIImageView()
    private let loginTitleLabel = UILabel()
    private let inputStackView = UIStackView()
    private let emailStackView = UIStackView()
    private let emailIcon = UIImageView()
    private let emailTextField = LoginTextField()
    private let passwordStackView = UIStackView()
    private let passwordIcon = UIImageView()
    private let passwordTextField = LoginTextField()
    private let signInButton = UIButton()

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: LoginScreenViewModel) {
        self.viewModel = viewModel
        super.init()

        bindView()
    }

    override func addSubviews() {
        super.addSubviews()
        addSubview(contentView)

        [
            logoImageView,
            loginTitleLabel,
            inputStackView,
            signInButton,
        ].forEach(contentView.addSubview(_:))

        [
            emailStackView,
            passwordStackView,
        ].forEach(inputStackView.addArrangedSubview(_:))

        [
            emailIcon,
            emailTextField,
        ].forEach(emailStackView.addArrangedSubview(_:))

        [
            passwordIcon,
            passwordTextField,
        ].forEach(passwordStackView.addArrangedSubview(_:))
    }

    override func setupSubviews() {
        super.setupSubviews()

        backgroundColor = Color.background

        logoImageView.image = UIImage(systemName: UIConstants.Image.logoImageViewTitle)
        logoImageView.tintColor = Color.darkTextColor

        loginTitleLabel.text = "Log in"
        loginTitleLabel.textColor = Color.darkTextColor
        loginTitleLabel.font = .systemFont(ofSize: 35, weight: .heavy)

        inputStackView.axis = .vertical
        inputStackView.spacing = 5

        emailStackView.axis = .horizontal

        emailIcon.image = UIImage(systemName: UIConstants.Image.emailIconImageTitle)
        emailIcon.tintColor = Color.darkTextColor
        emailIcon.contentMode = .center

        emailTextField.setupView(placeholderText: "Email")
        emailTextField.keyboardType = .emailAddress

        passwordStackView.axis = .horizontal

        passwordIcon.image = UIImage(systemName: UIConstants.Image.passwordIconImageTitle)
        passwordIcon.tintColor = Color.darkTextColor
        passwordIcon.contentMode = .center

        passwordTextField.setupView(placeholderText: "Password")
        passwordTextField.isSecureTextEntry = true

        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitle("", for: .disabled)
        signInButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        signInButton.backgroundColor = Color.darkButtonBackground
        signInButton.layer.cornerRadius = UIConstants.defaultCornerRadius
        signInButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()

        contentView.edgesToSuperview()

        logoImageView.size(UIConstants.loginLogoImageSize)

        emailIcon.size(UIConstants.defaultImageSize)

        passwordIcon.size(UIConstants.defaultImageSize)

        logoImageView.centerXToSuperview()
        logoImageView.topToSuperview(offset: 50)

        loginTitleLabel.topToBottom(of: logoImageView, offset: UIConstants.defaultLoginOffset)
        loginTitleLabel.centerX(to: logoImageView)

        inputStackView.topToBottom(of: loginTitleLabel, offset: UIConstants.defaultLoginOffset)
        inputStackView.widthToSuperview(multiplier: UIConstants.defaultWidthMultiplier)
        inputStackView.centerXToSuperview()

        signInButton.topToBottom(of: inputStackView, offset: UIConstants.defaultLoginOffset)
        signInButton.widthToSuperview(multiplier: UIConstants.defaultWidthMultiplier)
        signInButton.centerXToSuperview()
    }

    func bindView() {
        emailTextField
            .textPublisher
            .map { $0 }
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)

        passwordTextField
            .textPublisher
            .map { $0 }
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)
    }

    @objc private func loginButtonTapped() {
        DDLogInfo("User did tap login button")
        viewModel.logIn()
    }
}

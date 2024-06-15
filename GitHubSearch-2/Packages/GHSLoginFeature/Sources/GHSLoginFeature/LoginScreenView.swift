//
//  LoginScreenView.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 05/06/2024.
//

// import CocoaLumberjackSwift
import Combine
import GHSCoreUI
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
    private let loginInputView: UIView
    private let addAccountStackView = UIStackView()
    private let addAccountLabel = UILabel()
    private let addAccountButton = UIButton()

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: LoginScreenViewModel, loginInputView: UIView) {
        self.viewModel = viewModel
        self.loginInputView = loginInputView
        super.init()
    }

    override func addSubviews() {
        super.addSubviews()
        addSubview(contentView)

        [
            logoImageView,
            loginTitleLabel,
            loginInputView,
            addAccountStackView,
        ].forEach(contentView.addSubview(_:))

        [
            addAccountLabel,
            addAccountButton,
        ].forEach(addAccountStackView.addArrangedSubview(_:))
    }

    override func setupSubviews() {
        super.setupSubviews()

        backgroundColor = Color.background

        logoImageView.image = UIImage(systemName: UIConstants.Image.logoImageViewTitle)
        logoImageView.tintColor = Color.darkTextColor

        loginTitleLabel.text = "Log in"
        loginTitleLabel.textColor = Color.darkTextColor
        loginTitleLabel.font = .systemFont(ofSize: 35, weight: .heavy)

        addAccountStackView.spacing = 3
        addAccountStackView.alignment = .fill
        addAccountStackView.distribution = .fillProportionally

        addAccountLabel.text = "Don't have account?"
        addAccountLabel.textColor = .lightGray
        addAccountLabel.font = .systemFont(ofSize: 18, weight: .regular)
        addAccountLabel.textAlignment = .right
        addAccountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        addAccountButton.setTitle("Add account", for: .normal)
        addAccountButton.setTitleColor(.black, for: .normal)
        addAccountButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        addAccountButton.titleLabel?.textAlignment = .left
        addAccountButton.underline()
        addAccountButton.addTarget(viewModel, action: #selector(viewModel.addAccountButtonTapped), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()

        contentView.edgesToSuperview()

        logoImageView.size(UIConstants.loginLogoImageSize)

        logoImageView.centerXToSuperview()
        logoImageView.topToSuperview(offset: 50)

        loginTitleLabel.topToBottom(of: logoImageView, offset: UIConstants.defaultLoginOffset)
        loginTitleLabel.centerX(to: logoImageView)

        loginInputView.topToBottom(of: loginTitleLabel, offset: UIConstants.defaultLoginOffset)
        loginInputView.widthToSuperview(multiplier: UIConstants.defaultWidthMultiplier)
        loginInputView.centerXToSuperview()

        addAccountStackView.centerXToSuperview()
        addAccountStackView.topToBottom(of: loginInputView, offset: UIConstants.defaultLoginOffset)
    }
}

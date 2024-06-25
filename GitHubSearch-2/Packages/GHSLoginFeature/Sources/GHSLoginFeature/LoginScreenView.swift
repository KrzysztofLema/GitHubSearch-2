import Combine
import GHSCoreUI
import TinyConstraints
import UIKit

protocol LoginScreenViewDelegate: AnyObject {
    func loginScreenViewGoogleSignInButtonTapped(_ loginScreenView: LoginScreenView)
    func loginScreenViewSignInButtonTapped(_ loginScreenView: LoginScreenView)
    func loginScreenViewSignUpButtonTapped(_ loginScreenView: LoginScreenView)
    func loginScreenViewAppleSignInButtonTapped(_ loginScreenView: LoginScreenView)
}

final class LoginScreenView: BasicView {
    weak var delegate: LoginScreenViewDelegate?

    private let addAccountStackView = UIStackView()
    private let addAccountLabel = UILabel()
    private let addAccountButton = UIButton()
    private let authButtonsViewModels: [AuthenticationButtonViewModel]
    private let additionalAuthenticationButtonStackView = UIStackView()
    private let contentView = UIView()
    private let logoImageView = UIImageView()
    private let loginTitleLabel = UILabel()
    private let loginInputView: UIView
    private let signInButtonStackView = UIStackView()
    private let viewModel: LoginScreenViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: LoginScreenViewModel, loginInputView: UIView, authButtonsViewModels: [AuthenticationButtonViewModel]) {
        self.viewModel = viewModel
        self.loginInputView = loginInputView
        self.authButtonsViewModels = authButtonsViewModels
        super.init()
    }

    override func addSubviews() {
        super.addSubviews()
        addSubview(contentView)

        [
            logoImageView,
            loginTitleLabel,
            loginInputView,
            signInButtonStackView,
            addAccountStackView,
            additionalAuthenticationButtonStackView,
        ].forEach(contentView.addSubview(_:))

        [
            addAccountLabel,
            addAccountButton,
        ].forEach(addAccountStackView.addArrangedSubview(_:))

        addButtonsToStackView(viewModels: authButtonsViewModels)
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

        additionalAuthenticationButtonStackView.axis = .vertical
        additionalAuthenticationButtonStackView.spacing = UIConstants.defaultSpacing
        additionalAuthenticationButtonStackView.distribution = .fillEqually
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

        signInButtonStackView.topToBottom(of: loginInputView, offset: UIConstants.defaultLoginOffset)
        signInButtonStackView.widthToSuperview(multiplier: UIConstants.defaultWidthMultiplier)
        signInButtonStackView.centerXToSuperview()

        addAccountStackView.centerXToSuperview()
        addAccountStackView.topToBottom(of: signInButtonStackView, offset: UIConstants.defaultLoginOffset)

        additionalAuthenticationButtonStackView.topToBottom(of: addAccountStackView, offset: UIConstants.defaultLoginOffset)
        additionalAuthenticationButtonStackView.centerXToSuperview()
        additionalAuthenticationButtonStackView.widthToSuperview(multiplier: UIConstants.defaultWidthMultiplier)
    }

    private func addButtonsToStackView(viewModels: [AuthenticationButtonViewModel]) {
        viewModels
            .map(createAuthenticationButton(for:))
            .forEach {
                if $0.viewModel.type == .email {
                    signInButtonStackView.addArrangedSubview($0)
                } else {
                    additionalAuthenticationButtonStackView.addArrangedSubview($0)
                }
            }
    }

    private func createAuthenticationButton(for authenticationViewModel: AuthenticationButtonViewModel) -> AuthenticationButton {
        authenticationViewModel.delegate = self

        let authenticationButton = AuthenticationButton(authenticationViewModel: authenticationViewModel)

        authenticationButton.addTarget(viewModel, action: #selector(viewModel.didTapAuthenticationButton), for: .touchUpInside)
        return authenticationButton
    }
}

extension LoginScreenView: AuthenticationButtonViewModelDelegate {
    func authenticationViewModelAppleLoginButtonTapped(_ viewModel: AuthenticationButtonViewModel) {
        delegate?.loginScreenViewAppleSignInButtonTapped(self)
    }

    func authenticationViewModelGoogleLoginButtonTapped(_ viewModel: AuthenticationButtonViewModel) {
        delegate?.loginScreenViewGoogleSignInButtonTapped(self)
    }

    func authenticationViewModelEmailLoginButtonTapped(_ viewModel: AuthenticationButtonViewModel) {
        delegate?.loginScreenViewSignInButtonTapped(self)
    }

    func authenticationViewModelEmailAddUserButtonTapped(_ viewModel: AuthenticationButtonViewModel) {
        delegate?.loginScreenViewSignUpButtonTapped(self)
    }
}

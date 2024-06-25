import Combine
import GHSCoreUI
import GHSExtensions
import GHSModels
import UIKit

final class AuthenticationInputView: BasicView {
    private let viewModel: AuthenticationInputViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: AuthenticationInputViewModel) {
        self.viewModel = viewModel
        super.init()

        bindView()
    }

    private let inputStackView = UIStackView()
    private let emailStackView = UIStackView()
    private let emailIcon = UIImageView()
    private let emailTextField = AuthenticationTextField()
    private let passwordStackView = UIStackView()
    private let passwordIcon = UIImageView()
    private let passwordTextField = AuthenticationTextField()
    private let confirmPasswordStackView = UIStackView()
    private let confirmPasswordIcon = UIImageView()
    private let confirmPasswordTextField = AuthenticationTextField()
    private let validationLabel = UILabel()

    override func addSubviews() {
        super.addSubviews()

        [
            inputStackView,
        ].forEach(addSubview(_:))

        [
            emailStackView,
            passwordStackView,
            confirmPasswordStackView,
            validationLabel,
        ].forEach(inputStackView.addArrangedSubview(_:))

        [
            emailIcon,
            emailTextField,
        ].forEach(emailStackView.addArrangedSubview(_:))

        [
            passwordIcon,
            passwordTextField,
        ].forEach(passwordStackView.addArrangedSubview(_:))

        [
            confirmPasswordIcon,
            confirmPasswordTextField,
        ].forEach(confirmPasswordStackView.addArrangedSubview(_:))
    }

    override func setupSubviews() {
        super.setupSubviews()

        inputStackView.axis = .vertical
        inputStackView.spacing = 5

        emailIcon.image = UIImage(systemName: UIConstants.Image.emailIconImageTitle)
        emailIcon.tintColor = Color.darkTextColor
        emailIcon.contentMode = .center

        emailTextField.setupView(placeholderText: "Email")
        emailTextField.keyboardType = .emailAddress

        passwordIcon.image = UIImage(systemName: UIConstants.Image.passwordIconImageTitle)
        passwordIcon.tintColor = Color.darkTextColor
        passwordIcon.contentMode = .center

        passwordTextField.setupView(placeholderText: "Password")
        passwordTextField.isSecureTextEntry = true

        confirmPasswordIcon.image = UIImage(systemName: UIConstants.Image.passwordIconImageTitle)
        confirmPasswordIcon.tintColor = Color.darkTextColor
        confirmPasswordIcon.contentMode = .center

        confirmPasswordTextField.setupView(placeholderText: "Confirm password")
        confirmPasswordTextField.isSecureTextEntry = true
    }

    override func setupConstraints() {
        super.setupConstraints()

        emailIcon.size(UIConstants.defaultImageSize)
        passwordIcon.size(UIConstants.defaultImageSize)
        confirmPasswordIcon.size(UIConstants.defaultImageSize)

        inputStackView.edgesToSuperview()
    }
}

private extension AuthenticationInputView {
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

        confirmPasswordTextField
            .textPublisher
            .map { $0 }
            .assign(to: \.confirmPassword, on: viewModel)
            .store(in: &cancellables)

        viewModel
            .$viewType
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: setupInputView(_:))
            .store(in: &cancellables)

        viewModel
            .isPasswordMatching
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: setupValidationLabel(_:))
            .store(in: &cancellables)
    }
}

private extension AuthenticationInputView {
    func setupInputView(_ viewType: AuthenticationInputViewType) {
        switch viewType {
        case .login:
            UIView.animate(withDuration: 0.15) {
                self.validationLabel.isHidden = true
                self.confirmPasswordStackView.isHidden = true
            }
        case .addUser:
            UIView.animate(withDuration: 0.15) {
                self.validationLabel.isHidden = false
                self.validationLabel.text = ""
                self.confirmPasswordStackView.isHidden = false
            }
        }

        confirmPasswordTextField.text = nil
    }

    func setupValidationLabel(_ isMatching: Bool) {
        validationLabel.text = isMatching ? "Passwords match" : "Passwords do not match"
        validationLabel.textColor = isMatching ? Color.greenValidationTextColor : Color.redValidationTextColor
    }
}

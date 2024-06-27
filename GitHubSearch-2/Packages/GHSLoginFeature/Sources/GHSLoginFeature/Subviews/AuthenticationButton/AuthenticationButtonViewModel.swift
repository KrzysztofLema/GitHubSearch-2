import Combine
import Foundation
import GHSModels
import UIKit

protocol AuthenticationButtonViewModelDelegate: AnyObject {
    func authenticationViewModelFacebookLoginButtonTapped(_ viewModel: AuthenticationButtonViewModel)
    func authenticationViewModelAppleLoginButtonTapped(_ viewModel: AuthenticationButtonViewModel)
    func authenticationViewModelGoogleLoginButtonTapped(_ viewModel: AuthenticationButtonViewModel)
    func authenticationViewModelEmailLoginButtonTapped(_ viewModel: AuthenticationButtonViewModel)
    func authenticationViewModelEmailAddUserButtonTapped(_ viewModel: AuthenticationButtonViewModel)
}

final class AuthenticationButtonViewModel {
    @Published var viewType: AuthenticationInputViewType = .login

    weak var delegate: AuthenticationButtonViewModelDelegate?

    var buttonDidTap: ((AuthenticationButtonType) -> Void)?

    var title: String
    var isEnable: Bool
    let type: AuthenticationButtonType
    let image: UIImage?
    let baseBackgroundColor: UIColor
    let backgroundColor: UIColor

    func updateViewType() {
        viewType.toggle()
    }

    init(
        isEnable: Bool,
        type: AuthenticationButtonType,
        image: UIImage? = nil,
        baseBackgroundColor: UIColor,
        backgroundColor: UIColor
    ) {
        title = type.rawValue.capitalized
        self.isEnable = isEnable
        self.type = type
        self.image = image
        self.baseBackgroundColor = baseBackgroundColor
        self.backgroundColor = backgroundColor

        buttonDidTap = { [weak self] buttonType in
            guard let self else {
                return
            }

            switch viewType {
            case .login:
                handleDidLoginUserButtonTapped(with: buttonType)
            case .addUser:
                handleDidAddUserButtonTapped(with: buttonType)
            }
        }
    }

    private func handleDidAddUserButtonTapped(with type: AuthenticationButtonType) {
        switch type {
        case .email:
            delegate?.authenticationViewModelEmailAddUserButtonTapped(self)
        case .apple:
            delegate?.authenticationViewModelAppleLoginButtonTapped(self)
        case .google:
            delegate?.authenticationViewModelGoogleLoginButtonTapped(self)
        case .facebook:
            delegate?.authenticationViewModelFacebookLoginButtonTapped(self)
        }
    }

    private func handleDidLoginUserButtonTapped(with type: AuthenticationButtonType) {
        switch type {
        case .email:
            delegate?.authenticationViewModelEmailLoginButtonTapped(self)
        case .apple:
            delegate?.authenticationViewModelAppleLoginButtonTapped(self)
        case .google:
            delegate?.authenticationViewModelGoogleLoginButtonTapped(self)
        case .facebook:
            delegate?.authenticationViewModelFacebookLoginButtonTapped(self)
        }
    }
}

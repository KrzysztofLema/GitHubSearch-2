import Combine
import Foundation
import GHSModels
import UIKit

protocol AuthenticationButtonViewModelDelegate: AnyObject {
    func authenticationButtonViewModelDidTapEmailLogin(_ viewModel: AuthenticationButtonViewModel)
    func authenticationButtonViewModelDidTapEmailAddUser(_ viewModel: AuthenticationButtonViewModel)
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
        title: String,
        isEnable: Bool,
        type: AuthenticationButtonType,
        image: UIImage? = nil,
        baseBackgroundColor: UIColor,
        backgroundColor: UIColor
    ) {
        self.title = type.rawValue.capitalized
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
            delegate?.authenticationButtonViewModelDidTapEmailAddUser(self)
        case .apple:
            print("Apple")
        case .google:
            print("Google")
        case .facebook:
            print("Facebook")
        }
    }

    private func handleDidLoginUserButtonTapped(with type: AuthenticationButtonType) {
        switch type {
        case .email:
            delegate?.authenticationButtonViewModelDidTapEmailLogin(self)
        case .apple:
            print("Apple")
        case .google:
            print("Google")
        case .facebook:
            print("Facebook")
        }
    }
}

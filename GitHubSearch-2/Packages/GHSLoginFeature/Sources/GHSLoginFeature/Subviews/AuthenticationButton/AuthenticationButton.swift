import Combine
import GHSCoreUI
import GHSModels
import UIKit

final class AuthenticationButton: UIButton {
    var type: AuthenticationButtonType?
    var viewModel: AuthenticationButtonViewModel

    private var buttonConfiguration = UIButton.Configuration.filled()
    private var cancellables = Set<AnyCancellable>()

    init(authenticationViewModel: AuthenticationButtonViewModel) {
        viewModel = authenticationViewModel

        super.init(frame: .zero)

        setupSubviews()
        bindView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        type = viewModel.type

        layer.cornerRadius = UIConstants.defaultCornerRadius
        contentHorizontalAlignment = .leading
        contentMode = .scaleAspectFit

        buttonConfiguration.imagePlacement = .leading
        buttonConfiguration.imagePadding = 8
        buttonConfiguration.image = viewModel.image
        buttonConfiguration.baseForegroundColor = viewModel.baseBackgroundColor
        buttonConfiguration.background.backgroundColor = viewModel.backgroundColor

        if viewModel.type == .email {
            contentHorizontalAlignment = .center
        }

        if viewModel.type == .google {
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 2
        }
    }

    private func bindView() {
        viewModel
            .$viewType
            .sink(receiveValue: configureButtons(for:))
            .store(in: &cancellables)
    }

    private func configureButtons(for viewType: AuthenticationInputViewType) {
        switch viewType {
        case .login:
            buttonConfiguration.title = "Sign in with \(viewModel.title)"
        case .addUser:
            buttonConfiguration.title = "Sign up with \(viewModel.title)"
        }

        configuration = buttonConfiguration
    }
}

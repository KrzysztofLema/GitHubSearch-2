import Combine
import Foundation
import GHSCoreUI
import GHSDependecyInjection
import GHSModels
import UIKit

public protocol LoginScreenViewControllerDelegate: AnyObject {
    func loginScreenViewControllerSignInTapped(_ loginScreenViewController: LoginScreenViewController)
    func loginScreenViewControllerAddAccountTapped(_ loginScreenViewController: LoginScreenViewController)
}

public final class LoginScreenViewController: BasicViewController {
    @Injected(\.authenticationService) var authenticationService: AuthenticationServiceType

    public weak var delegate: LoginScreenViewControllerDelegate?

    private let viewModel: LoginScreenViewModel

    private lazy var authenticationInputViewModel = AuthenticationInputViewModel()

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmationPassword: String = ""

    private var cancellables = Set<AnyCancellable>()

    private lazy var loginInputViewController = AuthenticationInputViewController(viewModel: authenticationInputViewModel)

    public init(viewModel: LoginScreenViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        authenticationService.delegate = self
        (view as? LoginScreenView)?.delegate = self

        addChild(loginInputViewController)
        loginInputViewController.didMove(toParent: self)

        bindView()
    }

    override public func loadView() {
        view = LoginScreenView(
            viewModel: viewModel,
            loginInputView: loginInputViewController.view,
            authButtonsViewModels: viewModel.authButtonsViewModels
        )
    }

    private func bindView() {
        authenticationInputViewModel.$email
            .assign(to: \.email, on: self)
            .store(in: &cancellables)

        authenticationInputViewModel.$password
            .assign(to: \.password, on: self)
            .store(in: &cancellables)

        authenticationInputViewModel.$confirmPassword
            .assign(to: \.confirmationPassword, on: self)
            .store(in: &cancellables)
    }
}

extension LoginScreenViewController: LoginScreenViewModelDelegate {
    func loginScreenViewModelDidTapAddAccountButton(_: LoginScreenViewModel) {
        authenticationInputViewModel.viewType.toggle()
        for authButtonsViewModel in viewModel.authButtonsViewModels {
            authButtonsViewModel.updateViewType()
        }
    }
}

extension LoginScreenViewController: LoginScreenViewDelegate {
    func loginScreenViewFacebookSignInButtonTapped(_ loginScreenView: LoginScreenView) {
        authenticationService.signInWithFacebook()
    }

    func loginScreenViewGoogleSignInButtonTapped(_ loginScreenView: LoginScreenView) {
        authenticationService.sighInWithGoogle()
    }

    func loginScreenViewAppleSignInButtonTapped(_ loginScreenView: LoginScreenView) {
        authenticationService.signInWithApple()
    }

    func loginScreenViewSignInButtonTapped(_ loginViewModel: LoginScreenView) {
        authenticationService.signIn(with: email, password: password)
    }

    func loginScreenViewSignUpButtonTapped(_ loginScreenView: LoginScreenView) {
        authenticationService.createUser(with: email, password: password)
    }
}

extension LoginScreenViewController: AuthenticationServiceDelegate {
    public func authServiceUserDidLogIn() {
        delegate?.loginScreenViewControllerSignInTapped(self)
    }

    public func authService(didOccurError error: any Error) {}
}

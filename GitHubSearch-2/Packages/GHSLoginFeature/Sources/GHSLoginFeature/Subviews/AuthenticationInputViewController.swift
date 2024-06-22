import Foundation
import GHSCoreUI

final class AuthenticationInputViewController: BasicViewController {
    let viewModel: AuthenticationInputViewModel

    init(viewModel: AuthenticationInputViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = AuthenticationInputView(viewModel: viewModel)
    }
}



import UIKit

final class SendingDetailsViewController: UIViewController {
    private let _view: SendingDetailsView
    private let presenter: SendingDetailsPresenter

    init(_ presenter: SendingDetailsPresenter) {
        _view = SendingDetailsView()
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = _view
    }
}

extension SendingDetailsViewController {
    private func setupBindings() {}
}

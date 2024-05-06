

protocol SendingDetailsPresenterProtocol {
    var router: Router<SendingDetailsViewController> { get }
    var interactor: SendingDetailsInteractorProtocol { get }
}

final class SendingDetailsPresenter {
    let router: Router<SendingDetailsViewController>
    let interactor: SendingDetailsInteractorProtocol

    init(_ router: Router<SendingDetailsViewController>, _ interactor: SendingDetailsInteractorProtocol) {
        self.router = router
        self.interactor = interactor

        setupInput()
    }

    private func setupInput() {}
}

extension SendingDetailsPresenter: SendingDetailsPresenterProtocol {
    struct Input {}

    struct Output {}
}

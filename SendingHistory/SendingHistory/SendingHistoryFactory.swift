
final class SendingHistoryFactory {
    class func assembledScreen(_ router: SendingHistoryRouter = .init()) -> SendingHistoryViewController {
        let interactor = SendingHistoryInteractor()
        let presenter = SendingHistoryPresenter(router: router, interactor: interactor)
        let viewController = SendingHistoryViewController()
        viewController.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}


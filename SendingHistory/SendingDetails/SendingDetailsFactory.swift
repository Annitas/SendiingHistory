

final class SendingDetailsFactory {
    class func assembledScreen(_ router: SendingDetailsRouter = .init()) -> SendingDetailsViewController {
        let interactor = SendingDetailsInteractor()
        let presenter = SendingDetailsPresenter(router, interactor)
        let viewController = SendingDetailsViewController(presenter)
        router.viewController = viewController
        return viewController
    }
}

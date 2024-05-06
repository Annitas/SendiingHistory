
final class SendingDetailsRouter: Router<SendingDetailsViewController>, SendingDetailsRouter.Routes {

    typealias Routes = Any
}

protocol SendingDetailsRoute {
    var openSendingDetailsTransition: Transition { get }
    func openSendingDetails(_ date: HistoryDate)
}
extension SendingDetailsRoute where Self: RouterProtocol {
    func openSendingDetails(_ date: HistoryDate) {
        let router = SendingDetailsRouter()
        let viewController = SendingDetailsFactory.assembledScreen(router)
        openWithNextRouter(viewController, nextRouter: router, transition: openSendingDetailsTransition)
    }
}

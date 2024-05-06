

final class SendingHistoryRouter: Router<SendingHistoryViewController>, SendingHistoryRouter.Routes {
    var openSendingDetailsTransition: Transition = PushTransition()
    
    typealias Routes = SendingDetailsRoute
}

protocol SendingHistoryRoute {
    var openSendingHistoryTransition: Transition { get }
    func openSendingHistory()
}
extension SendingHistoryRoute where Self: RouterProtocol {
    func openSendingHistory() {
        let router = SendingHistoryRouter()
        let viewController = SendingHistoryFactory.assembledScreen(router)
        openWithNextRouter(viewController, nextRouter: router, transition: openSendingHistoryTransition)
    }
}





class SendingHistoryPresenter {
    let interactor: SendingHistoryInteractorProtocol
    var output: Output = .init() {
        didSet {
            outputChanged?()
        }
    }
    var input: Input = .init()
    
    struct Output {
        var viewModel: SendingHistoryViewModel = .init(dates: [])
    }
    struct Input {
        var dateSelected: ((Int) -> ())?
    }
    
    var outputChanged: (() -> ())?
    var router: Router<SendingHistoryViewController>
    
    init(router: Router<SendingHistoryViewController> = SendingHistoryRouter(), interactor: SendingHistoryInteractorProtocol = SendingHistoryInteractor(), output: Output = .init(), outputChanged: (() -> Void)? = nil) {
        self.router = router
        self.interactor = interactor
        self.output = output
        self.outputChanged = outputChanged
        Task {
            let array = await interactor.getDates().map { DateViewModel(date: $0.date) }
            await MainActor.run {
                self.output.viewModel = .init(dates: array)
            }
        }

        input.dateSelected = { [unowned self] dateIndex in
            let date = interactor.dates[dateIndex]
            (self.router as? SendingDetailsRoute)?.openSendingDetails(date)
        }
    }
}

protocol SendingHistoryInteractorProtocol {
    func getDates() async -> [HistoryDate] 
    var dates: [HistoryDate] { get }
}


//
//  SendingHistoryPresenterTests.swift
//  SendingHistoryTests
//
//  Created by Anita Stashevskaya on 06.05.2024.
//

import Foundation
import XCTest
@testable import SendingHistory

class SendingHistoryPresenterTests: XCTestCase {
    func test_presenterWhenItLoadsDatesFromInteractor_countOfOutputViewModelEqualToDatesFromInteractor() {
        let interactor = FakeSendingHistoryInteractor()
        interactor.datesCount = 2
        let sut = makeSUT(interactor: interactor)
        
        XCTAssertEqual(String(describing: type(of: interactor)), String(describing: type(of: sut.interactor)))
        let exp = expectation(description: "async")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            XCTAssertEqual(interactor.datesCount + 1, sut.output.viewModel.dates.count)
            exp.fulfill()
        })
        wait(for: [exp], timeout: 0.2)
    }

    func test_presenterWhenReceiveInputDateSelected_callsRoouterOpenDetails() {
        let interactor = FakeSendingHistoryInteractor()
        interactor.datesCount = 1
        let router = FakeSendingHistoryRouter()
        let sut = makeSUT(router: router, interactor: interactor)
        
        let exp = expectation(description: "async")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            sut.input.dateSelected?(0)
            XCTAssertTrue(router.openDetailsCalled)
            exp.fulfill()
        })
        wait(for: [exp], timeout: 0.2)
    }
    
    func makeSUT(router: Router<SendingHistoryViewController> = FakeSendingHistoryRouter(), interactor: SendingHistoryInteractorProtocol = FakeSendingHistoryInteractor()) -> SendingHistoryPresenter {
        let sut = SendingHistoryPresenter(router: router, interactor: interactor)
        return sut
    }
}

class FakeSendingHistoryInteractor: SendingHistoryInteractorProtocol {
    var dates: [SendingHistory.HistoryDate] = []
    
    var datesCount: Int = 0
    func getDates() async -> [HistoryDate] {
        
        var dates = stride(from: 0, through: datesCount, by: 1)
            .map {
                HistoryDate(date: "Date \($0)")
            }
        self.dates = dates
        return dates
    }
}
final class FakeSendingHistoryRouter: Router<SendingHistoryViewController>, SendingHistoryRouter.Routes {
    var openSendingDetailsTransition: SendingHistory.Transition = PushTransition()

    var openAddTagsTransition: Transition = PushTransition()
    var openFaceImageSearchTransition: Transition = PushTransition()

    var openDetailsCalled = false
    
    override func close(_ animated: Bool = true) {
    }
    
    func openSendingDetails(_ : HistoryDate) {
        openDetailsCalled = true
    }
}

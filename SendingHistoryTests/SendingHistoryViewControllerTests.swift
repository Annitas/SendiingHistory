//
//  SendingHistoryViewControllerTests.swift
//  SendingHistoryTests
//
//  Created by Anita Stashevskaya on 06.05.2024.
//

import XCTest
@testable import SendingHistory

final class SendingHistoryViewControllerTests: XCTestCase {
    func test_canInit() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.view)
        XCTAssertNotNil(sut.view.superview)
    }
    
    func test_viewController_hasTableView() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.tableView.delegate)
        
        XCTAssertNotNil(sut.tableView)
        XCTAssertEqual(sut.view, sut.tableView.superview)
        XCTAssertTrue(sut.tableView.frame.height > 0)
        XCTAssertTrue(sut.tableView.frame.width > 0)
        XCTAssertTrue(sut.tableView.frame.origin.x == 0)
    }

    func test_viewController_whenViewModelHasOneDate_displaysOneCell() throws {
        let sut = makeSUT()
        
        sut.viewModel = SendingHistoryViewModel(dates: [DateViewModel(date: "Horror")])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        let cell = try XCTUnwrap(sut.tableView.cellForRow(at:IndexPath(row: 0, section: 0)) as? DateTableViewCell)
        XCTAssertEqual(cell.dateLabel.text, sut.viewModel.dates[0].date)
    }

    func test_viewController_whenViewModelHasTwoDate_displaysTwoCells() throws {
        let sut = makeSUT()
        
        sut.viewModel = SendingHistoryViewModel(dates: [DateViewModel(date: "Horror"), DateViewModel(date: "Comedy")])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
        let cell = try XCTUnwrap(sut.tableView.cellForRow(at:IndexPath(row: 0, section: 0)) as? DateTableViewCell)
        XCTAssertEqual(cell.dateLabel.text, sut.viewModel.dates[0].date)
    }
    
    func test_viewController_loadsDataFromPresentersOutput() {
        let presenter = SendingHistoryPresenter()
        presenter.output.viewModel = .init(dates: [1, 2, 3].map { DateViewModel(date: "Film \($0)") })

        let sut = makeSUT(presenter: presenter)
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
    }

    func test_viewControllerWhenPresentersOutputHasChanged_tableViewCountAlsoChanged() {
        let presenter = SendingHistoryPresenter()
        presenter.output.viewModel = .init(dates: [1, 2, 3].map { DateViewModel(date: "Film \($0)") })

        let sut = makeSUT(presenter: presenter)
        presenter.output.viewModel = .init(dates: [1, 2, 3, 4].map { DateViewModel(date: "Film \($0)") })
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 4)
    }

    func test_viewControllerWhenTableViewSelected_callsPresentersInputDateSelected() {
        let interactor = FakeSendingHistoryInteractor()
        interactor.datesCount = 1
        let presenter = SendingHistoryPresenter(interactor: interactor)
        let sut = makeSUT(presenter: presenter)

        var called = false
        presenter.input.dateSelected = {
            XCTAssertEqual($0, 0)
            called = true
        }
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(called)
    }
    private func makeSUT(presenter: SendingHistoryPresenter = .init()) -> SendingHistoryViewController {
        let sut = SendingHistoryViewController()
        sut.presenter = presenter
        sut.renderOnWindow()
        return sut
    }
}

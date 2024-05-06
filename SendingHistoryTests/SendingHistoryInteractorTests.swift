//
//  SendingHistoryInteractorTests.swift
//  SendingHistoryTests
//
//  Created by Anita Stashevskaya on 06.05.2024.
//

import Foundation
@testable import SendingHistory
import XCTest

class SendingHistoryInteractorTests: XCTestCase {
    func test_interactor_canInit() {
        XCTAssertNotNil(SendingHistoryInteractor())
    }
    func test_interactorWhenGetDates_serviceGetDatesCalled() async {
        let service = FakeSomeService()
        let sut = SendingHistoryInteractor(service: service)
        
        await sut.getDates()
        
        XCTAssertTrue(service.getDatesCalled)
    }
}
class FakeSomeService: SomeServiceProtocol {
    func getDates() async -> [SendingHistory.HistoryDate] {
        getDatesCalled = true
        return []
    }
    var getDatesCalled = false
    
}


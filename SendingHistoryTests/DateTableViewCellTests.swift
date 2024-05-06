//
//  DateTableViewCellTests.swift
//  SendingHistoryTests
//
//  Created by Anita Stashevskaya on 06.05.2024.
//

import XCTest
@testable import SendingHistory

final class DateTableViewCellTests: XCTestCase {
    
    func test_cell_canInit() {
        let sut = makeSUT()
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.superview)
    }
    
    func test_cell_whenViewModel_labelHasSuperViewAndNonZeroHeight() {
        let sut = makeSUT()
        
        sut.viewModel = DateViewModel(date: "Some text")
        
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertEqual(sut.dateLabel.superview, sut.contentView)
        XCTAssertEqual(sut.dateLabel.textColor, .black)
        XCTAssertNotEqual(sut.dateLabel.frame.size.height, 0)
        XCTAssertNotEqual(sut.dateLabel.frame.size.width, 0)
        XCTAssertTrue(sut.dateLabel.frame.minX > 0)
        XCTAssertTrue(sut.dateLabel.frame.maxX < sut.contentView.frame.width)
    }

    func test_cell_whenReceivedDateWithLongName_labelFrameHeightIsMoreThanHeightOfNormalCellDateShortName() {
        let sut = makeSUT() //given
        
        //when
        sut.viewModel = DateViewModel(date: "Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long ")
        let shortCell = makeSUT()
        shortCell.viewModel = DateViewModel(date: "Long")

        shortCell.frame.size = shortCell.sizeThatFits(CGSize(width: shortCell.superview!.frame.width, height: .greatestFiniteMagnitude))
        sut.frame.size = sut.sizeThatFits(CGSize(width: sut.superview!.frame.width, height: .greatestFiniteMagnitude))
        
        //then
        XCTAssertEqual(sut.dateLabel.numberOfLines, 0)
        XCTAssertTrue(sut.frame.height >= shortCell.frame.height)
    }

    private func makeSUT() -> DateTableViewCell {
        let sut = DateTableViewCell()
        sut.renderOnWindow()
        return sut
    }
}

//
//  ViewModelTest.swift
//  FetchRewardsTests
//
//  Created by Iyin Raphael on 2/5/21.
//

import XCTest
@testable import FetchRewards

class ViewModelTest: XCTestCase {

    func testAllEventsArray() {
        guard let sut = SeatgeekViewModel().allEvent.value else { return }
        
        waitForExpectations(timeout: 8, handler: nil)
        
        XCTAssertTrue(!sut.isEmpty, "Array empty and not loading")
    }

}

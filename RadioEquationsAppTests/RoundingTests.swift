//
//  RoundingTests.swift
//  RadioEquationsAppTests
//
//  Created by Robert J. Sarvis Jr on 11/5/23.
//

import XCTest

final class RoundingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRounding() throws {
        var notRounded = 1.045
        var rounded = notRounded.rounded(toPlaces: 2)
        XCTAssertEqual(rounded, 1.05)
        
        notRounded = 1.034
        rounded = notRounded.rounded(toPlaces: 2)
        XCTAssertEqual(rounded, 1.03)
        
        notRounded = 1.05
        rounded = notRounded.rounded(toPlaces: 1)
        XCTAssertEqual(rounded, 1.1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

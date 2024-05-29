import XCTest
@testable import RadioEquationsData

final class RoundingTests: XCTestCase {
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
        measure {}
    }
}

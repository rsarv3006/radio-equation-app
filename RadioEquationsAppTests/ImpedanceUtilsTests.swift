import XCTest

final class ImpedanceUtilsTests: XCTestCase {
    func testCalculateImpedance() throws {
        let result = ImpedanceUtils.calculateImpedance(
            resistance: 5,
            inductiveReactance: 4,
            capacitiveReactance: 3
        )
        XCTAssertEqual(result, 5.10)
    }

    func testCalculateResistance() throws {
        let result = ImpedanceUtils.calculateResistance(
            impedance: 5,
            inductiveReactance: 4,
            capacitiveReactance: 3
        )
        XCTAssertEqual(result, 4.90)
    }


    func testCalculateResistanceReactanceGreaterThanImpedance() throws {
        let result = ImpedanceUtils.calculateResistance(
            impedance: 1,
            inductiveReactance: 1,
            capacitiveReactance: 3
        )
        XCTAssertTrue(result.isNaN)
    }

    func testCalculateInductiveReactance() throws {
        let result = ImpedanceUtils.calculateInductiveReactance(
            impedance: 5,
            resistance: 4,
            capacitiveReactance: 3
        )
        XCTAssertEqual(result, 6.00)
    }

    func testCalculateInductiveReactanceResistanceGreaterThanImpedance() throws {
        let result = ImpedanceUtils.calculateInductiveReactance(
            impedance: 1,
            resistance: 4,
            capacitiveReactance: 3
        )
        XCTAssertTrue(result.isNaN)
    }

    func testCalculateCapacitiveReactance() throws {
        let result = ImpedanceUtils.calculateCapacitiveReactance(
            impedance: 5,
            resistance: 4,
            inductiveReactance: 3
        )
        XCTAssertEqual(result, 0.00)
    }

    func testCalculateCapacitiveReactanceResistanceIsGreaterThanImpedance() throws {
        let result = ImpedanceUtils.calculateCapacitiveReactance(
            impedance: 1,
            resistance: 4,
            inductiveReactance: 3
        )
        XCTAssertTrue(result.isNaN)
    }


    func testPerformanceExample() throws {
        measure {}
    }
}

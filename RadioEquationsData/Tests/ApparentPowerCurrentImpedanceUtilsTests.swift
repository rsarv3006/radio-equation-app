import XCTest
@testable import RadioEquationsData

final class ApparentPowerCurrentImpedanceUtilsTests: XCTestCase {
    func testCalculateApparentPower() throws {
        var apparentPower = ApparentPowerCurrentImpedanceUtils.calculateApparentPower(
            current: 10.0,
            impedance: 20.0
        )
        XCTAssertEqual(apparentPower, 2000.0)

        apparentPower = ApparentPowerCurrentImpedanceUtils.calculateApparentPower(
            current: 50.0,
            impedance: 5.0
        )
        XCTAssertEqual(apparentPower, 12500.0)

        apparentPower = ApparentPowerCurrentImpedanceUtils.calculateApparentPower(
            current: 8.0,
            impedance: 31.8
        )
        XCTAssertEqual(apparentPower, 2035.2)
    }

    func testCalculateCurrent() throws {
        var current = ApparentPowerCurrentImpedanceUtils.calculateCurrent(
            apparentPower: 20.0,
            impedance: 2.0
        )
        XCTAssertEqual(current, 3.16)

        current = ApparentPowerCurrentImpedanceUtils.calculateCurrent(
            apparentPower: 25000.0,
            impedance: 500.0
        )
        XCTAssertEqual(current, 7.07)

        current = ApparentPowerCurrentImpedanceUtils.calculateCurrent(
            apparentPower: 25440.0,
            impedance: 318.0
        )
        XCTAssertEqual(current, 8.94)
    }

    func testCalculateImpedance() throws {
        var impedance = ApparentPowerCurrentImpedanceUtils.calculateImpedance(
            apparentPower: 200.0,
            current: 10.0
        )
        XCTAssertEqual(impedance, 2.0)

        impedance = ApparentPowerCurrentImpedanceUtils.calculateImpedance(
            apparentPower: 16.0,
            current: 2.0
        )
        XCTAssertEqual(impedance, 4.0)
    }
}

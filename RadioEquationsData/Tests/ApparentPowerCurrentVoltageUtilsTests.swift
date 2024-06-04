@testable import RadioEquationsData
import XCTest

final class ApparentPowerCurrentVoltageUtilsTests: XCTestCase {
    func testCalculateApparentPower() throws {
        var apparentPower = ApparentPowerCurrentVoltageUtils.calculateApparentPower(
            current: 10.0,
            voltage: 20.0
        )
        XCTAssertEqual(apparentPower, 200.0)

        apparentPower = ApparentPowerCurrentVoltageUtils.calculateApparentPower(
            current: 50.0,
            voltage: 500.0
        )
        XCTAssertEqual(apparentPower, 25000.0)

        apparentPower = ApparentPowerCurrentVoltageUtils.calculateApparentPower(
            current: 80.0,
            voltage: 318.0
        )
        XCTAssertEqual(apparentPower, 25440.0)
    }

    func testCalculateCurrent() throws {
        var current = ApparentPowerCurrentVoltageUtils.calculateCurrent(
            apparentPower: 200.0,
            voltage: 20.0
        )
        XCTAssertEqual(current, 10.0)

        current = ApparentPowerCurrentVoltageUtils.calculateCurrent(
            apparentPower: 25000.0,
            voltage: 500.0
        )
        XCTAssertEqual(current, 50.0)

        current = ApparentPowerCurrentVoltageUtils.calculateCurrent(
            apparentPower: 25440.0,
            voltage: 318.0
        )
        XCTAssertEqual(current, 80.0)
    }

    func testCalculateVoltage() throws {
        var voltage = ApparentPowerCurrentVoltageUtils.calculateVoltage(
            apparentPower: 200.0,
            current: 10.0
        )
        XCTAssertEqual(voltage, 20.0)

        voltage = ApparentPowerCurrentVoltageUtils.calculateVoltage(
            apparentPower: 25000.0,
            current: 50.0
        )
        XCTAssertEqual(voltage, 500.0)

        voltage = ApparentPowerCurrentVoltageUtils.calculateVoltage(
            apparentPower: 25440.0,
            current: 80.0
        )
        XCTAssertEqual(voltage, 318.0)
    }
}

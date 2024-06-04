import XCTest
@testable import RadioEquationsData

final class ApparentPowerVoltageImpedanceUtilsTests: XCTestCase {
    func testCalculateApparentPower() throws {
        var apparentPower = ApparentPowerVoltageImpedanceUtils.calculateApparentPower(
            voltage: 10.0,
            impedance: 20.0
        )
        XCTAssertEqual(apparentPower, 5.0)

        apparentPower = ApparentPowerVoltageImpedanceUtils.calculateApparentPower(
            voltage: 50.0,
            impedance: 500.0
        )
        XCTAssertEqual(apparentPower, 5.0)

        apparentPower = ApparentPowerVoltageImpedanceUtils.calculateApparentPower(
            voltage: 80.0,
            impedance: 318.0
        )
        XCTAssertEqual(apparentPower, 20.13)
    }

    func testCalculateVoltage() throws {
        var voltage = ApparentPowerVoltageImpedanceUtils.calculateVoltage(
            apparentPower: 50.0,
            impedance: 20.0
        )
        XCTAssertEqual(voltage, 31.62)

        voltage = ApparentPowerVoltageImpedanceUtils.calculateVoltage(
            apparentPower: 2500.0,
            impedance: 500.0
        )
        XCTAssertEqual(voltage, 1118.03)

        voltage = ApparentPowerVoltageImpedanceUtils.calculateVoltage(
            apparentPower: 2544.0,
            impedance: 318.0
        )
        XCTAssertEqual(voltage, 899.44)
    }

    func testCalculateImpedance() throws {
        var impedance = ApparentPowerVoltageImpedanceUtils.calculateImpedance(
            apparentPower: 50.0,
            voltage: 10.0
        )
        XCTAssertEqual(impedance, 2.0)

        impedance = ApparentPowerVoltageImpedanceUtils.calculateImpedance(
            apparentPower: 2500.0,
            voltage: 50.0
        )
        XCTAssertEqual(impedance, 1.0)

        impedance = ApparentPowerVoltageImpedanceUtils.calculateImpedance(
            apparentPower: 2544.0,
            voltage: 80.0
        )
        XCTAssertEqual(impedance, 2.52)
    }
}

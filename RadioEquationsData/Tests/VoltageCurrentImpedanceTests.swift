import XCTest

@testable import RadioEquationsData

final class VoltageCurrentImpedanceTests: XCTestCase {
    func testVoltage() {
        var voltage = VoltageCurrentImpedanceUtils.calculateVoltage(
            current: 1.0,
            impedance: 1.0
        )
        XCTAssertEqual(voltage, 1.0)

        voltage = VoltageCurrentImpedanceUtils.calculateVoltage(
            current: 5.0,
            impedance: 20.0
        )
        XCTAssertEqual(voltage, 100.0)
    }

    func testCurrent() {
        var current = VoltageCurrentImpedanceUtils.calculateCurrent(
            voltage: 1.0,
            impedance: 1.0
        )
        XCTAssertEqual(current, 1.0)

        current = VoltageCurrentImpedanceUtils.calculateCurrent(
            voltage: 1.0,
            impedance: 20.0
        )
        XCTAssertEqual(current, 0.05)
    }

    func testImpedance() {
        var impedance = VoltageCurrentImpedanceUtils.calculateImpedance(
            voltage: 1.0,
            current: 1.0
        )
        XCTAssertEqual(impedance, 1.0)

        impedance = VoltageCurrentImpedanceUtils.calculateImpedance(
            voltage: 100.0,
            current: 5.0
        )
        XCTAssertEqual(impedance, 20.0)
    }
}

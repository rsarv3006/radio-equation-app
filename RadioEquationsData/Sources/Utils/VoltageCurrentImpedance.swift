import Foundation

public struct VoltageCurrentImpedanceUtils: Codable {
    public static func calculateVoltage(current: Double, impedance: Double) -> Double {
        let voltage = current * impedance
        return voltage.rounded(toPlaces: 2)
    }

    public static func calculateCurrent(voltage: Double, impedance: Double) -> Double {
        let current = voltage / impedance
        return current.rounded(toPlaces: 2)
    }

    public static func calculateImpedance(voltage: Double, current: Double) -> Double {
        let impedance = voltage / current
        return impedance.rounded(toPlaces: 2)
    }

    public init(){}
}

extension VoltageCurrentImpedanceUtils: CalculationUtils {
    public func calculateFieldOne(_ inputs: Double...) -> Double {
        return VoltageCurrentImpedanceUtils.calculateVoltage(current: inputs[0], impedance: inputs[1])
    }

    public func calculateFieldTwo(_ inputs: Double...) -> Double {
        return VoltageCurrentImpedanceUtils.calculateCurrent(voltage: inputs[0], impedance: inputs[1])
    }

    public func calculateFieldThree(_ inputs: Double...) -> Double {
        return VoltageCurrentImpedanceUtils.calculateImpedance(voltage: inputs[0], current: inputs[1])
    }
}

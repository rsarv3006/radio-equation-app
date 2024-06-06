import Foundation

public struct ApparentPowerCurrentImpedanceUtils: Codable {
    public static func calculateApparentPower(current: Double, impedance: Double) -> Double {
        let apparentPower = current * current * impedance
        return apparentPower.rounded(toPlaces: 2)
    }

    public static func calculateCurrent(apparentPower: Double, impedance: Double) -> Double {
        let current = (apparentPower / impedance).squareRoot()
        return current.rounded(toPlaces: 2)
    }

    public static func calculateImpedance(apparentPower: Double, current: Double) -> Double {
        let impedance = apparentPower / (current * current)
        return impedance.rounded(toPlaces: 2)
    }
    
    public init() {}

}

extension ApparentPowerCurrentImpedanceUtils: CalculationUtils {
    public func calculateFieldOne(_ inputs: Double...) -> Double {
        return ApparentPowerCurrentImpedanceUtils.calculateApparentPower(current: inputs[0], impedance: inputs[1])
    }

    public func calculateFieldTwo(_ inputs: Double...) -> Double {
        return ApparentPowerCurrentImpedanceUtils.calculateCurrent(apparentPower: inputs[0], impedance: inputs[1])
    }

    public func calculateFieldThree(_ inputs: Double...) -> Double {
        return ApparentPowerCurrentImpedanceUtils.calculateImpedance(apparentPower: inputs[0], current: inputs[1])
    }
}

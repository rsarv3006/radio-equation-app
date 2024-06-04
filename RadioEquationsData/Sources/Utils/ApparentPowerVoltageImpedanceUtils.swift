import Foundation

public struct ApparentPowerVoltageImpedanceUtils: Codable {
    public static func calculateApparentPower(voltage: Double, impedance: Double) -> Double {
        let apparentPower = voltage * voltage / impedance
        return apparentPower.rounded(toPlaces: 2)
    }

    public static func calculateVoltage(apparentPower: Double, impedance: Double) -> Double {
        let voltage = (apparentPower * impedance).squareRoot()
        return voltage.rounded(toPlaces: 2)
    }

    public static func calculateImpedance(apparentPower: Double, voltage: Double) -> Double {
        let impedance = voltage * voltage / apparentPower
        return impedance.rounded(toPlaces: 2)
    }
    
    public init(){}
}

extension ApparentPowerVoltageImpedanceUtils: CalculationUtils {
    public func calculateFieldOne(_ inputs: Double...) -> Double {
        return ApparentPowerVoltageImpedanceUtils.calculateApparentPower(voltage: inputs[0], impedance: inputs[1])
    }

    public func calculateFieldTwo(_ inputs: Double...) -> Double {
        return ApparentPowerVoltageImpedanceUtils.calculateVoltage(apparentPower: inputs[0], impedance: inputs[1])
    }

    public func calculateFieldThree(_ inputs: Double...) -> Double {
        return ApparentPowerVoltageImpedanceUtils.calculateImpedance(apparentPower: inputs[0], voltage: inputs[1])
    }
}

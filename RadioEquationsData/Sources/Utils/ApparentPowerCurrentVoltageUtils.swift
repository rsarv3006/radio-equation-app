import Foundation

public struct ApparentPowerCurrentVoltageUtils: Codable {
    public static func calculateApparentPower(current: Double, voltage: Double) -> Double {
        let apparentPower = current * voltage
        return apparentPower.rounded(toPlaces: 2)
    }

    public static func calculateCurrent(apparentPower: Double, voltage: Double) -> Double {
        let current = apparentPower / voltage
        return current.rounded(toPlaces: 2)
    }

    public static func calculateVoltage(apparentPower: Double, current: Double) -> Double {
        let voltage = apparentPower / current
        return voltage.rounded(toPlaces: 2)
    }
    
    public init(){}
}

extension ApparentPowerCurrentVoltageUtils: CalculationUtils {
    public func calculateFieldOne(_ inputs: Double...) -> Double {
        return ApparentPowerCurrentVoltageUtils.calculateApparentPower(current: inputs[0], voltage: inputs[1])
    }
    
    public func calculateFieldTwo(_ inputs: Double...) -> Double {
        return ApparentPowerCurrentVoltageUtils.calculateCurrent(apparentPower: inputs[0], voltage: inputs[1])
    }

    public func calculateFieldThree(_ inputs: Double...) -> Double {
        return ApparentPowerCurrentVoltageUtils.calculateVoltage(apparentPower: inputs[0], current: inputs[1])
    }
}

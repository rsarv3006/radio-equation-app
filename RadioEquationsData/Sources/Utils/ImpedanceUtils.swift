import Foundation

public enum ImpedanceUtils {
    public static func calculateImpedance(resistance r: Double, inductiveReactance xl: Double, capacitiveReactance xc: Double) -> Double {
        let impedance = (pow(r, 2) + pow(xl - xc, 2)).squareRoot()
        return impedance.rounded(toPlaces: 2)
    }

    public static func calculateResistance(impedance z: Double, inductiveReactance xl: Double, capacitiveReactance xc: Double) -> Double {
        let resistance = (pow(z, 2) - pow(xl - xc, 2)).squareRoot()
        return resistance.rounded(toPlaces: 2)
    }

    public static func calculateCapacitiveReactance(impedance z: Double, resistance r: Double, inductiveReactance xl: Double) -> Double {
        return xl - (pow(z, 2) - pow(r, 2)).squareRoot()
    }

    public static func calculateInductiveReactance(impedance z: Double, resistance r: Double, capacitiveReactance xc: Double) -> Double {
        return (pow(z, 2) - pow(r, 2)).squareRoot() + xc
    }

}

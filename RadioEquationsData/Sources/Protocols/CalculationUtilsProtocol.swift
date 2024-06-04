import Foundation

public typealias CalculationFunction = (_: Double...) -> Double

public protocol CalculationUtils: Codable {
    func calculateFieldOne(_: Double...) -> Double
    func calculateFieldTwo(_: Double...) -> Double
    func calculateFieldThree(_: Double...) -> Double
}


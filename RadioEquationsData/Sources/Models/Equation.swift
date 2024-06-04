import Foundation

public struct Equation: Codable {
    public let title: String
    public let description: String
    public let id: EquationId
    public let filters: [EquationFilterVariant]
    public let pickerOptions: [String]
}

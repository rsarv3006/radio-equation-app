import Foundation

struct Equation: Codable {
    let title: String
    let description: String
    let id: EquationId
    let filters: [EquationFilterVariant]
}

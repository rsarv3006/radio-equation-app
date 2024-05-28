import Foundation
import Combine
import RadioEquationsData

enum PowerCurrentResistanceFieldTag: Int {
    case resistance = 2
    case current = 1
    case power = 0
    
    static func getFieldTagFromInt(fieldTagInt: Int) -> PowerCurrentResistanceFieldTag? {
        switch fieldTagInt {
        case PowerCurrentResistanceFieldTag.resistance.rawValue:
            return .resistance
        case PowerCurrentResistanceFieldTag.power.rawValue:
            return .power
        case PowerCurrentResistanceFieldTag.current.rawValue:
            return .current
        default:
            return nil
        }
    }
}

struct PowerCurrentResistanceCalculatedPassthroughModel {
    let fieldTag: PowerCurrentResistanceFieldTag
    let calculatedValue: Double
}

class PowerCurrentResistanceViewModel {
    private(set) var selectedCalculateFor: PowerCurrentResistanceFieldTag
   
    let equationTitle: String
    
    init(equation: Equation, calculateFor: PowerCurrentResistanceFieldTag = .power) {
        self.selectedCalculateFor = calculateFor
        self.equationTitle = equation.title
    }
    
    private var current: Double? = nil
    private var resistance: Double? = nil
    private var power: Double? = nil
    
    // MARK: - Properties
    private(set) var calculatedValue = PassthroughSubject<PowerCurrentResistanceCalculatedPassthroughModel, Never>()
    
    func onUpdateValue(fieldTag: PowerCurrentResistanceFieldTag, updatedValue: String) {
        guard let value = Double(updatedValue) else {
            return
        }
        switch fieldTag {
        case .current:
            current = value
        case .resistance:
            resistance = value
        case .power:
            power = value
        }
        
        attemptCalculation()
    }
    
    func onUpdatedCalculateFor(selectedIndex: Int) {
        selectedCalculateFor = PowerCurrentResistanceFieldTag(rawValue: selectedIndex) ?? .power
    }
    
    private func attemptCalculation() {
        switch selectedCalculateFor {
        case .current:
            calculateCurrent()
        case .resistance:
            calculateResistance()
        case .power:
            calculatePower()
        }
    }
    
    private func calculateCurrent() {
        guard let resistance = resistance, let power = power else {
            return
        }
        let calculatedCurrent = ((power / resistance).squareRoot()).rounded(toPlaces: 2)
        current = calculatedCurrent
        
        sendCalculatedValue(fieldTag: .current, value: calculatedCurrent)
    }
    
    private func calculatePower() {
        guard let current = current, let resistance = resistance else {
            return
        }
        let calculatedPower = ((current * current) * resistance).rounded(toPlaces: 2)
        power = calculatedPower
        
        sendCalculatedValue(fieldTag: .power, value: calculatedPower)
    }
    
    private func calculateResistance() {
        guard let current = current, let power = power else { return }
        let calculatedResistance = (power * (current * current)).rounded(toPlaces: 2)
        resistance = calculatedResistance
        sendCalculatedValue(fieldTag: .resistance, value: calculatedResistance)
    }
    
    private func clearValueForTag(fieldTag: PowerCurrentResistanceFieldTag) {
        switch fieldTag {
        case .current:
            current = nil
        case .resistance:
            resistance = nil
        case .power:
            power = nil
        }
    }
    
    private func sendCalculatedValue(fieldTag: PowerCurrentResistanceFieldTag, value: Double) {
        calculatedValue.send(PowerCurrentResistanceCalculatedPassthroughModel(fieldTag: fieldTag, calculatedValue: value))
    }
    
    
}

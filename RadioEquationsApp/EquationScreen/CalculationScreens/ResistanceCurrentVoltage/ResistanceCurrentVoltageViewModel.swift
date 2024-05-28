import Foundation
import Combine
import RadioEquationsData

struct ResistanceCurrentVoltageCalculatedPassthroughModel {
    let fieldTag: ResistanceCurrentVoltageFieldTag
    let calculatedValue: Double
}

class ResistanceCurrentVoltageViewModel {
    private(set) var selectedCalculateFor: ResistanceCurrentVoltageFieldTag
   
    let equationTitle: String
    
    init(equation: Equation, calculateFor: ResistanceCurrentVoltageFieldTag = .voltage) {
        self.selectedCalculateFor = calculateFor
        self.equationTitle = equation.title
    }
    
    private var resistance: Double? = nil
    private var current: Double? = nil
    private var voltage: Double? = nil
    
    // MARK: - Properties
    private(set) var calculatedValue = PassthroughSubject<ResistanceCurrentVoltageCalculatedPassthroughModel, Never>()
    
    func onUpdateValue(fieldTag: ResistanceCurrentVoltageFieldTag, updatedValue: String) {
        guard let value = Double(updatedValue) else {
            return
        }
        
        switch fieldTag {
        case .current:
            current = value
        case .resistance:
            resistance = value
        case .voltage:
            voltage = value
        }
        
        attemptCalculation()
    }
    
    func onUpdatedCalculateFor(selectedIndex: Int) {
        selectedCalculateFor = ResistanceCurrentVoltageFieldTag(rawValue: selectedIndex) ?? .voltage
    }
    
    private func attemptCalculation() {
        switch selectedCalculateFor {
        case .current:
            calculateCurrent()
        case .resistance:
            calculateResistance()
        case .voltage:
            calculateVoltage()
        }
    }
    
    private func calculateCurrent() {
        guard let voltage = voltage, let resistance = resistance else {
            return
        }
        let calculatedCurrent = (voltage / resistance).rounded(toPlaces: 2)
        current = calculatedCurrent
        
        sendCalculatedValue(fieldTag: .current, value: calculatedCurrent)
    }
    
    private func calculateResistance() {
        guard let voltage = voltage, let current = current else {
            return
        }
        let calculatedResistance = (voltage / current).rounded(toPlaces: 2)
        resistance = calculatedResistance
        
        sendCalculatedValue(fieldTag: .resistance, value: calculatedResistance)
    }
    
    private func calculateVoltage() {
        guard let current = current, let resistance = resistance else {
            return
        }
        let calculatedVoltage = (current * resistance).rounded(toPlaces: 2)
        
        voltage = calculatedVoltage
        
        sendCalculatedValue(fieldTag: .voltage, value: calculatedVoltage)
    }
    
    private func clearValueForTag(fieldTag: ResistanceCurrentVoltageFieldTag) {
        switch fieldTag {
        case .current:
            current = nil
        case .resistance:
            resistance = nil
        case .voltage:
            voltage = nil
        }
    }
    
    private func sendCalculatedValue(fieldTag: ResistanceCurrentVoltageFieldTag, value: Double) {
        calculatedValue.send(ResistanceCurrentVoltageCalculatedPassthroughModel(fieldTag: fieldTag, calculatedValue: value))
    }
    
    
}

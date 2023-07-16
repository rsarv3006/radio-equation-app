//
//  VoltagePowerResistanceViewModel.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 7/12/23.
//

import Foundation
import Combine

enum VoltagePowerResistanceFieldTag: Int {
    case voltage = 1
    case resistance = 2
    case power = 0
    
    static func getFieldTagFromInt(fieldTagInt: Int) -> VoltagePowerResistanceFieldTag? {
        switch fieldTagInt {
        case VoltagePowerResistanceFieldTag.voltage.rawValue:
            return .voltage
        case VoltagePowerResistanceFieldTag.power.rawValue:
            return .power
        case VoltagePowerResistanceFieldTag.resistance.rawValue:
            return .resistance
        default:
            return nil
        }
    }
}

struct VoltagePowerResistanceCalculatedPassthroughModel {
    let fieldTag: VoltagePowerResistanceFieldTag
    let calculatedValue: Double
}

class VoltagePowerResistanceViewModel {
    private(set) var selectedCalculateFor: VoltagePowerResistanceFieldTag
    
    init(calculateFor: VoltagePowerResistanceFieldTag = .voltage) {
        self.selectedCalculateFor = calculateFor
    }
    
    private var voltage: Double? = nil
    private var resistance: Double? = nil
    private var power: Double? = nil
    
    // MARK: - Properties
    private(set) var calculatedValue = PassthroughSubject<VoltagePowerResistanceCalculatedPassthroughModel, Never>()
    
    func onUpdateValue(fieldTag: VoltagePowerResistanceFieldTag, updatedValue: String) {
        guard let value = Double(updatedValue) else {
            return
        }
                
        switch fieldTag {
        case .voltage:
            voltage = value
        case .resistance:
            resistance = value
        case .power:
            power = value
        }
        
        attemptCalculation()
    }
    
    func onUpdatedCalculateFor(selectedIndex: Int) {
        selectedCalculateFor = VoltagePowerResistanceFieldTag(rawValue: selectedIndex) ?? .power
    }
    
    private func attemptCalculation() {
        switch selectedCalculateFor {
        case .voltage:
            calculateVoltage()
        case .resistance:
            calculateResistance()
        case .power:
            calculatePower()
        }
    }
    
    private func calculateVoltage() {
        guard let resistance = resistance, let power = power else {
            return
        }
        let calculatedVoltage = (power * resistance).squareRoot()
        voltage = calculatedVoltage
        
        sendCalculatedValue(fieldTag: .voltage, value: calculatedVoltage)
    }
    
    private func calculatePower() {
        guard let voltage = voltage, let resistance = resistance else {
            return
        }
        let calculatedPower = (voltage * voltage) / resistance
        
        power = calculatedPower
        
        sendCalculatedValue(fieldTag: .power, value: calculatedPower)
    }
    
    private func calculateResistance() {
        guard let voltage = voltage, let power = power else { return }
        let calculatedResistance = (voltage * voltage) / power
        resistance = calculatedResistance
        sendCalculatedValue(fieldTag: .resistance, value: calculatedResistance)
    }
    
    private func clearValueForTag(fieldTag: VoltagePowerResistanceFieldTag) {
        switch fieldTag {
        case .voltage:
            voltage = nil
        case .resistance:
            resistance = nil
        case .power:
            power = nil
        }
    }
    
    private func sendCalculatedValue(fieldTag: VoltagePowerResistanceFieldTag, value: Double) {
        calculatedValue.send(VoltagePowerResistanceCalculatedPassthroughModel(fieldTag: fieldTag, calculatedValue: value))
    }
    
    
}

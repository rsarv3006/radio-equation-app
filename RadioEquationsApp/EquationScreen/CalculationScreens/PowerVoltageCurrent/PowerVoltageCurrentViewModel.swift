//
//  PowerCalculationScreenViewModel.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/24/23.
//

import Foundation
import Combine

struct PowerVoltageCurrentPassthroughModel {
    let fieldTag: PowerVoltageCurrentFieldTag
    let calculatedValue: Double
}

class PowerVoltageCurrentViewModel {
    private(set) var selectedCalculateFor: PowerVoltageCurrentFieldTag
  
    let equationTitle: String
    
    init(equation: Equation, calculateFor: PowerVoltageCurrentFieldTag = .power) {
        self.selectedCalculateFor = calculateFor
        self.equationTitle = equation.title
    }
    
    private var current: Double? = nil
    private var voltage: Double? = nil
    private var power: Double? = nil
    
    // MARK: - Properties
    private(set) var calculatedValue = PassthroughSubject<PowerVoltageCurrentPassthroughModel, Never>()
    
    func onUpdateValue(fieldTag: PowerVoltageCurrentFieldTag, updatedValue: String) {
        guard let value = Double(updatedValue) else {
            return
        }
        
        switch fieldTag {
        case .current:
            current = value
        case .voltage:
            voltage = value
        case .power:
            power = value
        }
        
        attemptCalculation()
    }
    
    func onUpdatedCalculateFor(selectedIndex: Int) {
        selectedCalculateFor = PowerVoltageCurrentFieldTag(rawValue: selectedIndex) ?? .power
    }
    
    private func attemptCalculation() {
        switch selectedCalculateFor {
        case .current:
            calculateCurrent()
        case .voltage:
            calculateVoltage()
        case .power:
            calculatePower()
        }
    }
    
    private func calculateCurrent() {
        guard let voltage = voltage, let power = power else {
            return
        }
        let calculatedCurrent = power / voltage
        current = calculatedCurrent
        
        sendCalculatedValue(fieldTag: .current, value: calculatedCurrent)
    }
    
    private func calculatePower() {
        guard let current = current, let voltage = voltage else {
            return
        }
        let calculatedPower = current * voltage
        power = calculatedPower
        
        sendCalculatedValue(fieldTag: .power, value: calculatedPower)
    }
    
    private func calculateVoltage() {
        guard let current = current, let power = power else { return }
        let calculatedVoltage = power / current
        voltage = calculatedVoltage
        sendCalculatedValue(fieldTag: .voltage, value: calculatedVoltage)
    }
    
    private func clearValueForTag(fieldTag: PowerVoltageCurrentFieldTag) {
        switch fieldTag {
        case .current:
            current = nil
        case .voltage:
            voltage = nil
        case .power:
            power = nil
        }
    }
    
    private func sendCalculatedValue(fieldTag: PowerVoltageCurrentFieldTag, value: Double) {
        calculatedValue.send(PowerVoltageCurrentPassthroughModel(fieldTag: fieldTag, calculatedValue: value))
    }
    
    
}

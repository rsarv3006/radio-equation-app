//
//  OhmsLawCalculationScreenViewModel.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/22/23.
//

import Foundation
import Combine

struct OhmsLawCalculatedPassthroughModel {
    let fieldTag: OhmsLawFieldTag
    let calculatedValue: Double
}

class OhmsLawCalculationScreenViewModel {
    private var selectedCalculateFor: OhmsLawFieldTag = .voltage
    
    private var resistance: Double? = nil
    private var current: Double? = nil
    private var voltage: Double? = nil
    
    // MARK: - Properties
    private(set) var calculatedValue = PassthroughSubject<OhmsLawCalculatedPassthroughModel, Never>()
    
    func onUpdateValue(fieldTag: OhmsLawFieldTag, updatedValue: String) {
        print("fieldTag: \(fieldTag), updatedValue: \(updatedValue)")
        
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
        selectedCalculateFor = OhmsLawFieldTag(rawValue: selectedIndex) ?? .voltage
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
        let calculatedCurrent = voltage / resistance
        current = calculatedCurrent
        
        sendCalculatedValue(fieldTag: .current, value: voltage / resistance)
    }
    
    private func calculateResistance() {
        guard let voltage = voltage, let current = current else {
            return
        }
        let calculatedResistance = voltage / current
        resistance = calculatedResistance
        
        sendCalculatedValue(fieldTag: .resistance, value: voltage / current)
    }
    
    private func calculateVoltage() {
        guard let current = current, let resistance = resistance else {
            return
        }
        let calculatedVoltage = current * resistance
        voltage = calculatedVoltage
        
        sendCalculatedValue(fieldTag: .voltage, value: current * resistance)
    }
    
    private func clearValueForTag(fieldTag: OhmsLawFieldTag) {
        switch fieldTag {
        case .current:
            current = nil
        case .resistance:
            resistance = nil
        case .voltage:
            voltage = nil
        }
    }
    
    private func sendCalculatedValue(fieldTag: OhmsLawFieldTag, value: Double) {
        calculatedValue.send(OhmsLawCalculatedPassthroughModel(fieldTag: fieldTag, calculatedValue: value))
    }
    
    
}

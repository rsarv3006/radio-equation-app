import Foundation
import Combine

enum AntennaGainFieldTag: Int {
    case antennaGain = 0
    case powerOne = 1
    case powerTwo = 2
    
    static func getFieldTagFromInt(fieldTagInt: Int) -> AntennaGainFieldTag? {
        switch fieldTagInt {
        case AntennaGainFieldTag.antennaGain.rawValue:
            return .antennaGain
        case AntennaGainFieldTag.powerOne.rawValue:
            return .powerOne
        case AntennaGainFieldTag.powerTwo.rawValue:
            return .powerTwo
        default:
            return nil
        }
    }
}

struct AntennaGainFieldTagCalculatedPassthroughModel {
    let fieldTag: AntennaGainFieldTag
    let calculatedValue: Double
}

class AntennaGainViewModel {
    private(set) var selectedCalculateFor: AntennaGainFieldTag
    
    let equationTitle: String
    
    init(equation: Equation, calculateFor: AntennaGainFieldTag = .antennaGain) {
        self.selectedCalculateFor = calculateFor
        self.equationTitle = equation.title
    }
    
    private var antennaGain: Double? = nil
    private var powerOne: Double? = nil
    private var powerTwo: Double? = nil
    
    // MARK: - Properties
    private(set) var calculatedValue = PassthroughSubject<AntennaGainFieldTagCalculatedPassthroughModel, Never>()
    
    func onUpdateValue(fieldTag: AntennaGainFieldTag, updatedValue: String) {
        guard let value = Double(updatedValue) else {
            return
        }
                
        switch fieldTag {
        case .antennaGain:
            antennaGain = value
        case .powerOne:
            powerOne = value
        case .powerTwo:
            powerTwo = value
        }
        
        attemptCalculation()
    }
    
    func onUpdatedCalculateFor(selectedIndex: Int) {
        selectedCalculateFor = AntennaGainFieldTag(rawValue: selectedIndex) ?? .antennaGain}
    
    private func attemptCalculation() {
        print(selectedCalculateFor.rawValue)
        switch selectedCalculateFor {
        case .antennaGain:
            calculateAntennaGain()
        case .powerOne:
            calculatePowerOne()
        case .powerTwo:
            calculatePowerTwo()
        }
    }
    
    private func calculateAntennaGain() {
        guard let powerOne,
              let powerTwo else
        { return }
        
        let calculatedAntennaGain = AntennaGainUtils.calculateAntennaGain(powerOne: powerOne, powerTwo: powerTwo)
        antennaGain = calculatedAntennaGain
        
        sendCalculatedValue(fieldTag: .antennaGain, value: calculatedAntennaGain)
    }
    
    private func calculatePowerOne() {
        guard let antennaGain, let powerTwo else {
            return
        }
        let calculatedPowerOne = AntennaGainUtils.calculatePowerOne(antennaGain: antennaGain, powerTwo: powerTwo)
        
        powerOne = calculatedPowerOne
        
        sendCalculatedValue(fieldTag: .powerOne, value: calculatedPowerOne)
    }
    
    private func calculatePowerTwo() {
        guard let antennaGain, let powerOne else { return }
        let calculatedPowerTwo = AntennaGainUtils.calculatePowerTwo(antennaGain: antennaGain, powerOne: powerOne)

        powerTwo = calculatedPowerTwo

        sendCalculatedValue(fieldTag: .powerTwo, value: calculatedPowerTwo)
    }
    
    private func clearValueForTag(fieldTag: AntennaGainFieldTag) {
        switch fieldTag {
        case .antennaGain:
            antennaGain = nil
        case .powerOne:
            powerOne = nil
        case .powerTwo:
            powerTwo = nil
        }
    }
    
    private func sendCalculatedValue(fieldTag: AntennaGainFieldTag, value: Double) {
        calculatedValue.send(AntennaGainFieldTagCalculatedPassthroughModel(fieldTag: fieldTag, calculatedValue: value))
    }
}

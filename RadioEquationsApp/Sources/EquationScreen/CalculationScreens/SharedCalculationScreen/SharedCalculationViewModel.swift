import Combine
import Foundation
import RadioEquationsData

struct SharedCalculationPassthroughModel {
    let fieldTag: SharedCalculationFieldTag
    let calculatedValue: Double
}

class SharedCalculationViewModel {
    private(set) var selectedCalculateFor: SharedCalculationFieldTag
    private let calculationUtils: CalculationUtils

    let equationTitle: String
    let pickerOptions: [String]

    init(
        equation: Equation,
        calculateFor: SharedCalculationFieldTag,
        calculationUtils: CalculationUtils
    ) {
        selectedCalculateFor = calculateFor
        equationTitle = equation.title
        self.calculationUtils = calculationUtils
        self.pickerOptions = equation.pickerOptions
    }

    private var fieldOne: Double?
    private var fieldTwo: Double?
    private var fieldThree: Double?

    private(set) var calculatedValue = PassthroughSubject<SharedCalculationPassthroughModel, Never>()

    func onUpdateValue(fieldTag: SharedCalculationFieldTag, updatedValue: String) {
        guard let value = Double(updatedValue) else {
            return
        }

        switch fieldTag {
        case .fieldOne:
            fieldOne = value
        case .fieldTwo:
            fieldTwo = value
        case .fieldThree:
            fieldThree = value
        }

        attemptCalculation()
    }

    func onUpdatedCalculateFor(selectedIndex: Int) {
        selectedCalculateFor = SharedCalculationFieldTag(rawValue: selectedIndex) ?? .fieldOne
    }

    private func attemptCalculation() {
        switch selectedCalculateFor {
        case .fieldOne:
            guard let fieldTwo, let fieldThree else { return }
            let calculatedFieldOne = calculationUtils.calculateFieldOne(fieldTwo, fieldThree)
            fieldOne = calculatedFieldOne
            sendCalculatedValue(fieldTag: .fieldOne, value: calculatedFieldOne)

        case .fieldTwo:
            guard let fieldOne, let fieldThree else { return }
            let calculatedFieldTwo = calculationUtils.calculateFieldTwo(fieldOne, fieldThree)
            fieldTwo = calculatedFieldTwo
            sendCalculatedValue(fieldTag: .fieldTwo, value: calculatedFieldTwo)

        case .fieldThree:
            guard let fieldOne, let fieldTwo else { return }
            let calculatedFieldThree = calculationUtils.calculateFieldThree(fieldOne, fieldTwo)
            fieldThree = calculatedFieldThree
            sendCalculatedValue(fieldTag: .fieldThree, value: calculatedFieldThree)
        }
    }

    private func sendCalculatedValue(fieldTag: SharedCalculationFieldTag, value: Double) {
        calculatedValue.send(SharedCalculationPassthroughModel(fieldTag: fieldTag, calculatedValue: value))
    }

    private func clearValueForTag(fieldTag: SharedCalculationFieldTag) {
        switch fieldTag {
        case .fieldOne:
            fieldOne = nil
        case .fieldTwo:
            fieldTwo = nil
        case .fieldThree:
            fieldThree = nil
        }
    }

}

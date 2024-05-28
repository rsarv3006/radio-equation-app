import Combine
import Foundation
import RadioEquationsData

enum ApparentPowerVoltageCurrentFieldTag: Int {
    case impedance = 0
    case resistance = 1
    case inductiveReactance = 2
    case capacitiveReactance = 3

    static func getFieldTagFromInt(fieldTagInt: Int) -> ApparentPowerVoltageCurrentFieldTag? {
        switch fieldTagInt {
        case ApparentPowerVoltageCurrentFieldTag.impedance.rawValue:
            return .impedance
        case ApparentPowerVoltageCurrentFieldTag.resistance.rawValue:
            return .resistance
        case ApparentPowerVoltageCurrentFieldTag.inductiveReactance.rawValue:
            return .inductiveReactance
        case ApparentPowerVoltageCurrentFieldTag.capacitiveReactance.rawValue:
            return .capacitiveReactance
        default:
            return nil
        }
    }
}

struct ApparentPowerFieldTagCalculatedPassthroughModel {
    let fieldTag: ApparentPowerVoltageCurrentFieldTag
    let calculatedValue: Double
}

class ApparentPowerVoltageCurrentViewModel {
    private(set) var selectedCalculateFor: ApparentPowerVoltageCurrentFieldTag

    let equationTitle: String

    init(equation: Equation, calculateFor: ApparentPowerVoltageCurrentFieldTag = .impedance) {
        selectedCalculateFor = calculateFor
        equationTitle = equation.title
    }

    private var impedance: Double?
    private var resistance: Double?
    private var inductiveReactance: Double?
    private var capacitiveReactance: Double?

    // MARK: - Properties

    private(set) var calculatedValue = PassthroughSubject<ApparentPowerFieldTagCalculatedPassthroughModel, Never>()

    func onUpdateValue(fieldTag: ApparentPowerVoltageCurrentFieldTag, updatedValue: String) {
        guard let value = Double(updatedValue) else {
            return
        }

        switch fieldTag {
        case .impedance:
            impedance = value
        case .resistance:
            resistance = value
        case .inductiveReactance:
            inductiveReactance = value
        case .capacitiveReactance:
            capacitiveReactance = value
        }

        attemptCalculation()
    }

    func onUpdatedCalculateFor(selectedIndex: Int) {
        selectedCalculateFor = ApparentPowerVoltageCurrentFieldTag(rawValue: selectedIndex) ?? .impedance
    }

    private func attemptCalculation() {
        print(selectedCalculateFor.rawValue)
        switch selectedCalculateFor {
        case .impedance:
            calculateImpedance()
        case .resistance:
            calculateResistance()
        case .inductiveReactance:
            calculateInductiveReactance()
        case .capacitiveReactance:
            calculateCapacitiveReactance()
        }
    }

    private func calculateImpedance() {
        guard let resistance,
              let inductiveReactance,
              let capacitiveReactance
        else { return }

        let calculatedImpedance = ApparentPowerCurrentVoltageUtils.calculateImpedance(resistance: resistance, inductiveReactance: inductiveReactance, capacitiveReactance: capacitiveReactance)
        impedance = calculatedImpedance

        sendCalculatedValue(fieldTag: .impedance, value: calculatedImpedance)
    }

    private func calculateResistance() {
        guard let impedance, let inductiveReactance, let capacitiveReactance
        else {
            return
        }
        let calculatedResistance = ApparentPowerCurrentVoltageUtils.calculateResistance(impedance: impedance, inductiveReactance: inductiveReactance, capacitiveReactance: capacitiveReactance)

        resistance = calculatedResistance

        sendCalculatedValue(fieldTag: .resistance, value: calculatedResistance)
    }

    private func calculateInductiveReactance() {
        guard let impedance, let resistance, let capacitiveReactance
        else { return }
        let calculatedInductiveReactance = ApparentPowerCurrentVoltageUtils.calculateInductiveReactance(impedance: impedance, resistance: resistance, capacitiveReactance: capacitiveReactance)

        inductiveReactance = calculatedInductiveReactance

        sendCalculatedValue(fieldTag: .inductiveReactance, value: calculatedInductiveReactance)
    }

    private func calculateCapacitiveReactance() {}

    private func clearValueForTag(fieldTag: ApparentPowerVoltageCurrentFieldTag) {
        switch fieldTag {
        case .impedance:
            impedance = nil
        case .resistance:
            resistance = nil
        case .inductiveReactance:
            inductiveReactance = nil
        case .capacitiveReactance:
            capacitiveReactance = nil
        }
    }

    private func sendCalculatedValue(fieldTag: ApparentPowerVoltageCurrentFieldTag, value: Double) {
        calculatedValue.send(ApparentPowerFieldTagCalculatedPassthroughModel(fieldTag: fieldTag, calculatedValue: value))
    }
}

import Combine
import Foundation
import RadioEquationsData

enum ImpedanceFieldTag: Int {
    case impedance = 0
    case resistance = 1
    case inductiveReactance = 2
    case capacitiveReactance = 3

    static func getFieldTagFromInt(fieldTagInt: Int) -> ImpedanceFieldTag? {
        switch fieldTagInt {
        case ImpedanceFieldTag.impedance.rawValue:
            return .impedance
        case ImpedanceFieldTag.resistance.rawValue:
            return .resistance
        case ImpedanceFieldTag.inductiveReactance.rawValue:
            return .inductiveReactance
        case ImpedanceFieldTag.capacitiveReactance.rawValue:
            return .capacitiveReactance
        default:
            return nil
        }
    }
}

struct ImpedanceFieldTagCalculatedPassthroughModel {
    let fieldTag: ImpedanceFieldTag
    let calculatedValue: Double
}

class ImpedanceViewModel {
    private(set) var selectedCalculateFor: ImpedanceFieldTag

    let equationTitle: String
    let impedanceNanNote = "NOTE: 'nan' indicates a non real answer. Please see the description screen for more information."

    init(equation: Equation, calculateFor: ImpedanceFieldTag = .impedance) {
        selectedCalculateFor = calculateFor
        equationTitle = equation.title
    }

    private var impedance: Double?
    private var resistance: Double?
    private var inductiveReactance: Double?
    private var capacitiveReactance: Double?

    // MARK: - Properties

    private(set) var calculatedValue = PassthroughSubject<ImpedanceFieldTagCalculatedPassthroughModel, Never>()

    func onUpdateValue(fieldTag: ImpedanceFieldTag, updatedValue: String) {
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
        selectedCalculateFor = ImpedanceFieldTag(rawValue: selectedIndex) ?? .impedance
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

        let calculatedImpedance = ImpedanceUtils.calculateImpedance(resistance: resistance, inductiveReactance: inductiveReactance, capacitiveReactance: capacitiveReactance)
        impedance = calculatedImpedance

        sendCalculatedValue(fieldTag: .impedance, value: calculatedImpedance)
    }

    private func calculateResistance() {
        guard let impedance, let inductiveReactance, let capacitiveReactance
        else {
            return
        }
        let calculatedResistance = ImpedanceUtils.calculateResistance(impedance: impedance, inductiveReactance: inductiveReactance, capacitiveReactance: capacitiveReactance)

        resistance = calculatedResistance

        sendCalculatedValue(fieldTag: .resistance, value: calculatedResistance)
    }

    private func calculateInductiveReactance() {
        guard let impedance, let resistance, let capacitiveReactance
        else { return }
        let calculatedInductiveReactance = ImpedanceUtils.calculateInductiveReactance(impedance: impedance, resistance: resistance, capacitiveReactance: capacitiveReactance)

        inductiveReactance = calculatedInductiveReactance

        sendCalculatedValue(fieldTag: .inductiveReactance, value: calculatedInductiveReactance)
    }

    private func calculateCapacitiveReactance() {}

    private func clearValueForTag(fieldTag: ImpedanceFieldTag) {
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

    private func sendCalculatedValue(fieldTag: ImpedanceFieldTag, value: Double) {
        calculatedValue.send(ImpedanceFieldTagCalculatedPassthroughModel(fieldTag: fieldTag, calculatedValue: value))
    }
}

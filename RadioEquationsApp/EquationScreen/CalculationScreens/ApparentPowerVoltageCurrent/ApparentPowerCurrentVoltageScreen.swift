import Combine
import Foundation
import RichTextView
import UIKit

class ApparentPowerCurrentVoltageScreen: UIViewController {
    private var subscriptions = Set<AnyCancellable>()

    var viewModel: ApparentPowerVoltageCurrentViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            viewModel.calculatedValue.sink { calculatedValueObj in
                switch calculatedValueObj.fieldTag {
                case .impedance:
                    self.impedanceStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .capacitiveReactance:
                    self.capacitiveReactanceStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .resistance:
                    self.resistanceStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .inductiveReactance:
                    self.inductiveReactanceStack.inputField.text = String(calculatedValueObj.calculatedValue)
                }
            }.store(in: &subscriptions)

            switch viewModel.selectedCalculateFor {
            case .impedance:
                calculateForSegmentedControl.selectedSegmentIndex = 0
                makeImpedanceFieldAnswerBox()
            case .resistance:
                calculateForSegmentedControl.selectedSegmentIndex = 1
                makeResistanceFieldAnswerBox()
            case .inductiveReactance:
                calculateForSegmentedControl.selectedSegmentIndex = 2
                makeInductiveReactanceFieldAnswerBox()
            case .capacitiveReactance:
                calculateForSegmentedControl.selectedSegmentIndex = 3
                makeCapacitiveReactanceFieldAnswerBox()
            }

            equationLabel.update(input: viewModel.equationTitle)
        }
    }

    private lazy var equationLabel: RichTextView = {
        let richTextView = RichTextView(
            input: "",
            latexParser: LatexParser(),
            font: UIFont.systemFont(ofSize: 18),
            textColor: UIColor.Theme.textColor,
            latexTextBaselineOffset: 6,
            frame: CGRect.zero,
            completion: nil
        )

        return richTextView
    }()

    private lazy var calculateForPickerOptions = ["Impedance", "Resistance", "Inductive Reactance", "Capacitive Reactance"]

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calculate for:"
        label.textColor = .Theme.textColor
        return label
    }()

    private lazy var impedanceStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: ImpedanceFieldTag.impedance.rawValue, fieldLabelText: "Impedance (Z):")
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()

    private lazy var resistanceStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: ImpedanceFieldTag.resistance.rawValue, fieldLabelText: "Resistance (R):")
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()

    private lazy var inductiveReactanceStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: ImpedanceFieldTag.inductiveReactance.rawValue, fieldLabelText: "Inductive Reactance (X_L):")
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()

    private lazy var capacitiveReactanceStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: ImpedanceFieldTag.capacitiveReactance.rawValue, fieldLabelText: "Capacitive Reactance (X_C):")
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()

    private lazy var calculateForSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: calculateForPickerOptions)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(didCalculateForSegmentedControlChange), for: .valueChanged)

        return control
    }()

    override func viewDidLoad() {
        view.backgroundColor = .Theme.backgroundColor
        configureView()
    }

    private func configureView() {
        view.addSubview(equationLabel)

        equationLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12)

        view.addSubview(titleLabel)
        view.addSubview(calculateForSegmentedControl)

        titleLabel.centerX(inView: view, topAnchor: equationLabel.bottomAnchor, paddingTop: 12)

        calculateForSegmentedControl.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)

        view.addSubview(impedanceStack)

        impedanceStack.anchor(top: calculateForSegmentedControl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)

        view.addSubview(resistanceStack)

        resistanceStack.anchor(top: impedanceStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)

        view.addSubview(inductiveReactanceStack)
        inductiveReactanceStack.anchor(
            top: resistanceStack.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 12,
            paddingLeft: 12,
            paddingRight: 12
        )

        view.addSubview(capacitiveReactanceStack)

        capacitiveReactanceStack.anchor(top: inductiveReactanceStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
    }
}

extension ApparentPowerCurrentVoltageScreen {
    @objc func didFieldUpdate(_ textField: UITextField) {
        guard let fieldTag = ApparentPowerVoltageCurrentFieldTag.getFieldTagFromInt(fieldTagInt: textField.tag), let fieldText = textField.text else { return }
        viewModel?.onUpdateValue(fieldTag: fieldTag, updatedValue: fieldText)
    }

    @objc func didCalculateForSegmentedControlChange(_ segmentedControl: UISegmentedControl) {
        guard let fieldTag = ApparentPowerVoltageCurrentFieldTag.getFieldTagFromInt(fieldTagInt: segmentedControl.selectedSegmentIndex) else { return }
        viewModel?.onUpdatedCalculateFor(selectedIndex: segmentedControl.selectedSegmentIndex)
        makeTextFieldAnswerBox(fieldTag: fieldTag)
    }

    private func makeTextFieldAnswerBox(fieldTag: ApparentPowerVoltageCurrentFieldTag) {
        switch fieldTag {
        case .impedance:
            makeImpedanceFieldAnswerBox()
        case .resistance:
            makeResistanceFieldAnswerBox()
        case .inductiveReactance:
            makeInductiveReactanceFieldAnswerBox()
        case .capacitiveReactance:
            makeCapacitiveReactanceFieldAnswerBox()
        }
    }

    private func makeImpedanceFieldAnswerBox() {
        impedanceStack.inputField.isAnswerField = true
        resistanceStack.inputField.isAnswerField = false
        inductiveReactanceStack.inputField.isAnswerField = false
        capacitiveReactanceStack.inputField.isAnswerField = false
    }

    private func makeResistanceFieldAnswerBox() {
        impedanceStack.inputField.isAnswerField = false
        resistanceStack.inputField.isAnswerField = true
        inductiveReactanceStack.inputField.isAnswerField = false
        capacitiveReactanceStack.inputField.isAnswerField = false
    }

    private func makeInductiveReactanceFieldAnswerBox() {
        impedanceStack.inputField.isAnswerField = false
        resistanceStack.inputField.isAnswerField = false
        inductiveReactanceStack.inputField.isAnswerField = true
        capacitiveReactanceStack.inputField.isAnswerField = false
    }

    private func makeCapacitiveReactanceFieldAnswerBox() {
        impedanceStack.inputField.isAnswerField = false
        resistanceStack.inputField.isAnswerField = false
        inductiveReactanceStack.inputField.isAnswerField = false
        capacitiveReactanceStack.inputField.isAnswerField = true
    }
}

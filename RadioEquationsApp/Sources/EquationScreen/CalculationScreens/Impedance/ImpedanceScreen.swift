import Combine
import Foundation
import RichTextView
import UIKit

class ImpedanceScreen: UIViewController {
    private var subscriptions = Set<AnyCancellable>()

    var viewModel: ImpedanceViewModel? {
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
            nanAnswerNote.text = viewModel.impedanceNanNote
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

    private lazy var calculateForPickerOptions = [
        NSLocalizedString("Impedance", comment: "Option for impedance calculation"),
        NSLocalizedString("Resistance", comment: "Option for resistance calculation"),
        NSLocalizedString("Inductive Reactance", comment: "Option for inductive reactance calculation"),
        NSLocalizedString("Capacitive Reactance", comment: "Option for capacitive reactance calculation")
    ]

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calculate for:"
        label.textColor = .Theme.textColor
        return label
    }()

    private lazy var impedanceStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: ImpedanceFieldTag.impedance.rawValue, fieldLabelText: NSLocalizedString("Impedance (Z):", comment: "Label for impedance input field"))
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()

    private lazy var resistanceStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: ImpedanceFieldTag.resistance.rawValue, fieldLabelText: NSLocalizedString("Resistance (R):", comment: "Label for resistance input field"))
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()

    private lazy var inductiveReactanceStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: ImpedanceFieldTag.inductiveReactance.rawValue, fieldLabelText: NSLocalizedString("Inductive Reactance (X_L):", comment: "Label for inductive reactance input field"))
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()

    private lazy var capacitiveReactanceStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: ImpedanceFieldTag.capacitiveReactance.rawValue, fieldLabelText: NSLocalizedString("Capacitive Reactance (X_C):", comment: "Label for capacitive reactance input field"))
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()

    private lazy var calculateForSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: calculateForPickerOptions)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(didCalculateForSegmentedControlChange), for: .valueChanged)

        return control
    }()

    private lazy var nanAnswerNote: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
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

        view.addSubview(nanAnswerNote)
        nanAnswerNote.centerX(inView: view, topAnchor: capacitiveReactanceStack.bottomAnchor, paddingTop: 24)
        nanAnswerNote.anchor(left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingLeft: 12, paddingRight: 12) 
    }
}

extension ImpedanceScreen {
    @objc func didFieldUpdate(_ textField: UITextField) {
        guard let fieldTag = ImpedanceFieldTag.getFieldTagFromInt(fieldTagInt: textField.tag), let fieldText = textField.text else { return }
        viewModel?.onUpdateValue(fieldTag: fieldTag, updatedValue: fieldText)
    }

    @objc func didCalculateForSegmentedControlChange(_ segmentedControl: UISegmentedControl) {
        guard let fieldTag = ImpedanceFieldTag.getFieldTagFromInt(fieldTagInt: segmentedControl.selectedSegmentIndex) else { return }
        viewModel?.onUpdatedCalculateFor(selectedIndex: segmentedControl.selectedSegmentIndex)
        makeTextFieldAnswerBox(fieldTag: fieldTag)
    }

    private func makeTextFieldAnswerBox(fieldTag: ImpedanceFieldTag) {
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

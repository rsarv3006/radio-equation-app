import UIKit
import Combine
import RichTextView

class PowerVoltageCurrentScreen: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: PowerVoltageCurrentViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            viewModel.calculatedValue.sink { calculatedValueObj in
                switch calculatedValueObj.fieldTag {
                case .current:
                    self.currentStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .power:
                    self.powerStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .voltage:
                    self.voltageStack.inputField.text = String(calculatedValueObj.calculatedValue)
                }
            }.store(in: &subscriptions)
            
            switch viewModel.selectedCalculateFor {
            case .power:
                calculateForSegmentedControl.selectedSegmentIndex = 0
                makePowerFieldAnswerBox()
            case .current:
                calculateForSegmentedControl.selectedSegmentIndex = 1
                makeCurrentFieldAnswerBox()
            case .voltage:
                calculateForSegmentedControl.selectedSegmentIndex = 2
                makeVoltageFieldAnswerBox()
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
            frame: CGRect.zero,
            completion: nil
        )
        
        return richTextView
    }()
    
    private lazy var calculateForPickerOptions = [
        NSLocalizedString("Power", comment: "Option for power calculation"),
        NSLocalizedString("Current", comment: "Option for current calculation"),
        NSLocalizedString("Voltage", comment: "Option for voltage calculation")
    ]

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Calculate for:", comment: "Label for calculation type selection")
        label.textColor = .Theme.textColor
        return label
    }()

    private lazy var voltageStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: PowerVoltageCurrentFieldTag.voltage.rawValue, fieldLabelText: NSLocalizedString("Voltage (E):", comment: "Label for voltage input field"))
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()

    private lazy var currentStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: PowerVoltageCurrentFieldTag.current.rawValue, fieldLabelText: NSLocalizedString("Current (I):", comment: "Label for current input field"))
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()

    private lazy var powerStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: PowerVoltageCurrentFieldTag.power.rawValue, fieldLabelText: NSLocalizedString("Power (P):", comment: "Label for power input field"))
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
        
        equationLabel.centerX(inView: self.view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12)
        
        view.addSubview(titleLabel)
        view.addSubview(calculateForSegmentedControl)
        
        titleLabel.centerX(inView: view, topAnchor: equationLabel.bottomAnchor, paddingTop: 12)
        
        calculateForSegmentedControl.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(currentStack)
        
        currentStack.anchor(top: calculateForSegmentedControl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(voltageStack)
        
        voltageStack.anchor(top: currentStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(powerStack)
        
        powerStack.anchor(top: voltageStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
    }
}

extension PowerVoltageCurrentScreen {
    @objc func didFieldUpdate(_ textField: UITextField) {
        guard let fieldTag = PowerVoltageCurrentFieldTag.getFieldTagFromInt(fieldTagInt: textField.tag), let fieldText = textField.text else { return }
        viewModel?.onUpdateValue(fieldTag: fieldTag, updatedValue: fieldText)
    }
    
    @objc func didCalculateForSegmentedControlChange(_ segmentedControl: UISegmentedControl) {
        guard let fieldTag = PowerVoltageCurrentFieldTag.getFieldTagFromInt(fieldTagInt: segmentedControl.selectedSegmentIndex) else { return }
        viewModel?.onUpdatedCalculateFor(selectedIndex: segmentedControl.selectedSegmentIndex)
        makeTextFieldAnswerBox(fieldTag: fieldTag)
    }
    
    private func makeTextFieldAnswerBox(fieldTag: PowerVoltageCurrentFieldTag) {
        switch fieldTag {
        case .current:
            makeCurrentFieldAnswerBox()
        case .power:
            makePowerFieldAnswerBox()
        case .voltage:
            makeVoltageFieldAnswerBox()
        }
    }
    
    private func makeCurrentFieldAnswerBox() {
        currentStack.inputField.isAnswerField = true
        powerStack.inputField.isAnswerField = false
        voltageStack.inputField.isAnswerField = false
    }
    
    private func makePowerFieldAnswerBox() {
        currentStack.inputField.isAnswerField = false
        powerStack.inputField.isAnswerField = true
        voltageStack.inputField.isAnswerField = false
    }
    
    private func makeVoltageFieldAnswerBox() {
        currentStack.inputField.isAnswerField = false
        powerStack.inputField.isAnswerField = false
        voltageStack.inputField.isAnswerField = true
    }
}



import UIKit
import Combine
import RichTextView

enum ResistanceCurrentVoltageFieldTag: Int {
    case current = 2
    case resistance = 1
    case voltage = 0
}

class ResistanceCurrentVoltageScreen: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: ResistanceCurrentVoltageViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            viewModel.calculatedValue.sink { calculatedValueObj in
                switch calculatedValueObj.fieldTag {
                case .current:
                    self.currentStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .resistance:
                    self.resistanceStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .voltage:
                    self.voltageStack.inputField.text = String(calculatedValueObj.calculatedValue)
                }
            }.store(in: &subscriptions)
            
            switch viewModel.selectedCalculateFor {
            case .voltage:
                calculateForSegmentedControl.selectedSegmentIndex = 0
                makeVoltageFieldAnswerField()
            case .resistance:
                calculateForSegmentedControl.selectedSegmentIndex = 1
                makeResistanceFieldAnswerField()
            case .current:
                calculateForSegmentedControl.selectedSegmentIndex = 2
                makeCurrentFieldAnswerField()
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
    
    private lazy var calculateForPickerOptions = ["Voltage", "Resistance", "Current"]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calculate for:"
        label.textColor = .Theme.textColor
        return label
    }()
    
    private lazy var calculateForSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: calculateForPickerOptions)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(didCalculateForSegmentedControlChange), for: .valueChanged)
        return control
    }()
    
    private lazy var voltageStack: CalculationFieldStackView = {
        let stackView = CalculationFieldStackView(fieldTag: ResistanceCurrentVoltageFieldTag.voltage.rawValue, fieldLabelText: "Voltage (E):")
        stackView.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stackView
    }()
    
    private lazy var currentStack: CalculationFieldStackView = {
        let stackView = CalculationFieldStackView(fieldTag: ResistanceCurrentVoltageFieldTag.current.rawValue, fieldLabelText: "Current (I):")
        stackView.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stackView
    }()
    
    private lazy var resistanceStack: CalculationFieldStackView = {
        let stackView = CalculationFieldStackView(fieldTag: ResistanceCurrentVoltageFieldTag.resistance.rawValue, fieldLabelText: "Resistance (R):")
        stackView.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stackView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .Theme.backgroundColor
        configureView()
    }
    
    private func configureView() {
        view.addSubview(equationLabel)
        
        equationLabel.centerX(inView: self.view, topAnchor: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 12)
        
        view.addSubview(titleLabel)
        view.addSubview(calculateForSegmentedControl)
        
        titleLabel.centerX(inView: view, topAnchor: equationLabel.bottomAnchor, paddingTop: 12)
        
        calculateForSegmentedControl.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(currentStack)
        
        currentStack.anchor(top: calculateForSegmentedControl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(resistanceStack)
        
        resistanceStack.anchor(top: currentStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(voltageStack)
        
        voltageStack.anchor(top: resistanceStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
    }
}

extension ResistanceCurrentVoltageScreen {
    @objc func didFieldUpdate(_ textField: UITextField) {
        guard let fieldTag = findFieldTagFromInt(fieldTag: textField.tag), let fieldText = textField.text else { return }
        viewModel?.onUpdateValue(fieldTag: fieldTag, updatedValue: fieldText)
    }
    
    @objc func didCalculateForSegmentedControlChange(_ segmentedControl: UISegmentedControl) {
        guard let fieldTag = findFieldTagFromInt(fieldTag: segmentedControl.selectedSegmentIndex) else { return }
        viewModel?.onUpdatedCalculateFor(selectedIndex: segmentedControl.selectedSegmentIndex)
        makeTextFieldAnswerBox(fieldTag: fieldTag)
    }
    
    private func findFieldTagFromInt(fieldTag: Int) -> ResistanceCurrentVoltageFieldTag? {
        switch fieldTag {
        case 0:
            return .voltage
        case 1:
            return .resistance
        case 2:
            return .current
        default:
            return nil
        }
    }
    
    private func makeTextFieldAnswerBox(fieldTag: ResistanceCurrentVoltageFieldTag) {
        switch fieldTag {
        case .current:
            makeCurrentFieldAnswerField()
        case .resistance:
            makeResistanceFieldAnswerField()
        case .voltage:
            makeVoltageFieldAnswerField()
        }
    }
    
    private func makeCurrentFieldAnswerField() {
        currentStack.inputField.isAnswerField = true
        resistanceStack.inputField.isAnswerField = false
        voltageStack.inputField.isAnswerField = false
    }
    
    private func makeResistanceFieldAnswerField() {
        currentStack.inputField.isAnswerField = false
        resistanceStack.inputField.isAnswerField = true
        voltageStack.inputField.isAnswerField = false
    }
    
    private func makeVoltageFieldAnswerField() {
        currentStack.inputField.isAnswerField = false
        resistanceStack.inputField.isAnswerField = false
        voltageStack.inputField.isAnswerField = true
    }
}


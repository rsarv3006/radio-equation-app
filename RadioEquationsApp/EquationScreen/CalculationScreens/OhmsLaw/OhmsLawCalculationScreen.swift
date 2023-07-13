//
//  OhmsLawCalculationScreen.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/20/23.
//

import UIKit
import Combine

enum OhmsLawFieldTag: Int {
    case current = 2
    case resistance = 1
    case voltage = 0
}

class OhmsLawCalculationScreen: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: OhmsLawCalculationScreenViewModel? {
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
        }
    }
    
    private lazy var calculateForPickerOptions = ["Voltage", "Resistance", "Current"]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calculate for:"
        return label
    }()
    
    private lazy var calculateForSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: calculateForPickerOptions)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(didCalculateForSegmentedControlChange), for: .valueChanged)
        
        return control
    }()
    
    private lazy var voltageStack: CalculationFieldStackView = {
        let stackView = CalculationFieldStackView(fieldTag: OhmsLawFieldTag.voltage.rawValue, fieldLabelText: "Voltage (E):")
        stackView.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stackView
    }()
    
    private lazy var currentStack: CalculationFieldStackView = {
        let stackView = CalculationFieldStackView(fieldTag: OhmsLawFieldTag.current.rawValue, fieldLabelText: "Current (I):")
        stackView.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stackView
    }()
        
    private lazy var resistanceStack: CalculationFieldStackView = {
        let stackView = CalculationFieldStackView(fieldTag: OhmsLawFieldTag.resistance.rawValue, fieldLabelText: "Resistance (R):")
        stackView.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stackView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        configureView()
    }
    
    private func configureView() {
        view.addSubview(titleLabel)
        view.addSubview(calculateForSegmentedControl)
        
        titleLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12)
        
        calculateForSegmentedControl.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(currentStack)
        
        currentStack.anchor(top: calculateForSegmentedControl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
            
        view.addSubview(resistanceStack)
        
        resistanceStack.anchor(top: currentStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(voltageStack)
        voltageStack.inputField.isAnswerField = true
        
        voltageStack.anchor(top: resistanceStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
    }
}

extension OhmsLawCalculationScreen {
    @objc func didFieldUpdate(_ textField: UITextField) {
        guard let fieldTag = findFieldTagFromInt(fieldTag: textField.tag), let fieldText = textField.text else { return }
        viewModel?.onUpdateValue(fieldTag: fieldTag, updatedValue: fieldText)
    }
    
    @objc func didCalculateForSegmentedControlChange(_ segmentedControl: UISegmentedControl) {
        guard let fieldTag = findFieldTagFromInt(fieldTag: segmentedControl.selectedSegmentIndex) else { return }
        viewModel?.onUpdatedCalculateFor(selectedIndex: segmentedControl.selectedSegmentIndex)
        makeTextFieldAnswerBox(fieldTag: fieldTag)
    }
    
    private func findFieldTagFromInt(fieldTag: Int) -> OhmsLawFieldTag? {
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
    
    private func makeTextFieldAnswerBox(fieldTag: OhmsLawFieldTag) {
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


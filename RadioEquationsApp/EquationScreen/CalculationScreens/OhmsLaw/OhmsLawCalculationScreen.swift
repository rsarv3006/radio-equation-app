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
                    self.currentField.text = String(calculatedValueObj.calculatedValue)
                case .resistance:
                    self.resistanceField.text = String(calculatedValueObj.calculatedValue)
                case .voltage:
                    self.voltageField.text = String(calculatedValueObj.calculatedValue)
                    print("voltage: \(calculatedValueObj.calculatedValue)")
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
    
    private lazy var voltageLabel: UILabel = {
        let label = UILabel()
        label.text = "Voltage (E):"
        return label
    }()
    
    private lazy var currentLabel: UILabel = {
        let label = UILabel()
        label.text = "Current (I):"
        return label
    }()
    
    private lazy var resistanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Resistance (R):"
        return label
    }()
    
    private lazy var calculateForSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: calculateForPickerOptions)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(didCalculateForSegmentedControlChange), for: .valueChanged)
        
        return control
    }()
    
    
    private lazy var voltageField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tag = OhmsLawFieldTag.voltage.rawValue
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        textField.isEnabled = false
        textField.layer.borderColor = UIColor.green.cgColor
        return textField
    }()
    
    private lazy var currentField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tag = OhmsLawFieldTag.current.rawValue
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return textField
    }()
    
    private lazy var resistanceField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tag = OhmsLawFieldTag.resistance.rawValue
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return textField
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
        
        let currentStack = UIStackView(arrangedSubviews: [currentLabel, currentField])
        currentStack.axis = .horizontal
        
        view.addSubview(currentStack)
        
        currentStack.anchor(top: calculateForSegmentedControl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        
        let resistanceLabel = UIStackView(arrangedSubviews: [resistanceLabel, resistanceField])
        resistanceLabel.axis = .horizontal
        
        view.addSubview(resistanceLabel)
        
        resistanceLabel.anchor(top: currentStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        let voltageStack = UIStackView(arrangedSubviews: [voltageLabel, voltageField])
        voltageStack.axis = .horizontal
        
        view.addSubview(voltageStack)
        
        voltageStack.anchor(top: resistanceLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
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
            makeCurrentFieldAnswerBox()
        case .resistance:
            makeResistanceFieldAnswerBox()
        case .voltage:
            makeVoltageFieldAnswerBox()
        }
    }
    
    private func makeCurrentFieldAnswerBox() {
        currentField.isEnabled = false
        currentField.layer.borderColor = UIColor.green.cgColor
        resistanceField.isEnabled = true
        resistanceField.layer.borderColor = UIColor.clear.cgColor
        voltageField.isEnabled = true
        voltageField.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func makeResistanceFieldAnswerBox() {
        currentField.isEnabled = true
        currentField.layer.borderColor = UIColor.clear.cgColor
        resistanceField.isEnabled = false
        resistanceField.layer.borderColor = UIColor.green.cgColor
        voltageField.isEnabled = true
        voltageField.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func makeVoltageFieldAnswerBox() {
        currentField.isEnabled = true
        currentField.layer.borderColor = UIColor.clear.cgColor
        resistanceField.isEnabled = true
        resistanceField.layer.borderColor = UIColor.clear.cgColor
        voltageField.isEnabled = false
        voltageField.layer.borderColor = UIColor.green.cgColor
    }
    
    
    
}


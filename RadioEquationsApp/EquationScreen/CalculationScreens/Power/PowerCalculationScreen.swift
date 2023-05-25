//
//  PowerCalculationScreen.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/24/23.
//

import UIKit
import Combine

class PowerCalculationScreen: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: PowerCalculationScreenViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            viewModel.calculatedValue.sink { calculatedValueObj in
                switch calculatedValueObj.fieldTag {
                case .current:
                    self.currentField.text = String(calculatedValueObj.calculatedValue)
                case .power:
                    self.powerField.text = String(calculatedValueObj.calculatedValue)
                case .voltage:
                    self.voltageField.text = String(calculatedValueObj.calculatedValue)
                }
            }.store(in: &subscriptions)
        }
    }
    
    private lazy var calculateForPickerOptions = ["Power", "Current", "Voltage"]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calculate for:"
        return label
    }()
    
    private lazy var voltageLabel: UILabel = {
        let label = UILabel()
        label.text = "Voltage (V):"
        return label
    }()
    
    private lazy var currentLabel: UILabel = {
        let label = UILabel()
        label.text = "Current (I):"
        return label
    }()
    
    private lazy var powerLabel: UILabel = {
        let label = UILabel()
        label.text = "Power (P):"
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
        textField.tag = PowerFieldTag.voltage.rawValue
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return textField
    }()
    
    private lazy var currentField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tag = PowerFieldTag.current.rawValue
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return textField
    }()
    
    private lazy var powerField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tag = PowerFieldTag.power.rawValue
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        textField.isEnabled = false
        textField.layer.borderColor = UIColor.green.cgColor
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
        
        let voltageStack = UIStackView(arrangedSubviews: [voltageLabel, voltageField])
        voltageStack.axis = .horizontal
        
        view.addSubview(voltageStack)
        
        voltageStack.anchor(top: currentStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        let powerStack = UIStackView(arrangedSubviews: [powerLabel, powerField])
        powerStack.axis = .horizontal
        
        view.addSubview(powerStack)
        
        powerStack.anchor(top: voltageStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
    }
}

extension PowerCalculationScreen {
    @objc func didFieldUpdate(_ textField: UITextField) {
        guard let fieldTag = PowerFieldTag.getFieldTagFromInt(fieldTagInt: textField.tag), let fieldText = textField.text else { return }
        viewModel?.onUpdateValue(fieldTag: fieldTag, updatedValue: fieldText)
    }
    
    @objc func didCalculateForSegmentedControlChange(_ segmentedControl: UISegmentedControl) {
        guard let fieldTag = PowerFieldTag.getFieldTagFromInt(fieldTagInt: segmentedControl.selectedSegmentIndex) else { return }
        viewModel?.onUpdatedCalculateFor(selectedIndex: segmentedControl.selectedSegmentIndex)
        makeTextFieldAnswerBox(fieldTag: fieldTag)
    }
    
    private func makeTextFieldAnswerBox(fieldTag: PowerFieldTag) {
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
        currentField.isEnabled = false
        currentField.layer.borderColor = UIColor.green.cgColor
        powerField.isEnabled = true
        powerField.layer.borderColor = UIColor.clear.cgColor
        voltageField.isEnabled = true
        voltageField.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func makePowerFieldAnswerBox() {
        currentField.isEnabled = true
        currentField.layer.borderColor = UIColor.clear.cgColor
        powerField.isEnabled = false
        powerField.layer.borderColor = UIColor.green.cgColor
        voltageField.isEnabled = true
        voltageField.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func makeVoltageFieldAnswerBox() {
        currentField.isEnabled = true
        currentField.layer.borderColor = UIColor.clear.cgColor
        powerField.isEnabled = true
        powerField.layer.borderColor = UIColor.clear.cgColor
        voltageField.isEnabled = false
        voltageField.layer.borderColor = UIColor.green.cgColor
    }
}



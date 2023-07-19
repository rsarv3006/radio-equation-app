//
//  PowerCurrentResistanceScreen.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 7/12/23.
//

import UIKit
import Combine

class PowerCurrentResistanceScreen: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: PowerCurrentResistanceViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            viewModel.calculatedValue.sink { calculatedValueObj in
                switch calculatedValueObj.fieldTag {
                case .current:
                    self.currentStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .power:
                    self.powerStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .resistance:
                    self.resistanceStack.inputField.text = String(calculatedValueObj.calculatedValue)
                }
            }.store(in: &subscriptions)
            
            switch viewModel.selectedCalculateFor {
            case .power:
                calculateForSegmentedControl.selectedSegmentIndex = 0
                makePowerFieldAnswerBox()
            case .current:
                calculateForSegmentedControl.selectedSegmentIndex = 1
                makeCurrentFieldAnswerBox()
            case .resistance:
                calculateForSegmentedControl.selectedSegmentIndex = 2
                makeResistanceFieldAnswerBox()
                
            }
        }
    }
    
    private lazy var calculateForPickerOptions = ["Power", "Current", "Resistance"]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calculate for:"
        label.textColor = .Theme.textColor
        return label
    }()
    
    private lazy var resistanceStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: PowerCurrentResistanceFieldTag.resistance.rawValue, fieldLabelText: "Resistance (R):")
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()
    
    private lazy var currentStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: PowerCurrentResistanceFieldTag.current.rawValue, fieldLabelText: "Current (I):")
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()
    
    private lazy var powerStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: PowerCurrentResistanceFieldTag.power.rawValue, fieldLabelText: "Power (P):")
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
        view.addSubview(titleLabel)
        view.addSubview(calculateForSegmentedControl)
        
        titleLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12)
        
        calculateForSegmentedControl.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(currentStack)
        
        currentStack.anchor(top: calculateForSegmentedControl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(resistanceStack)
        
        resistanceStack.anchor(top: currentStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(powerStack)
        
        powerStack.anchor(top: resistanceStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
    }
}

extension PowerCurrentResistanceScreen {
    @objc func didFieldUpdate(_ textField: UITextField) {
        guard let fieldTag = PowerCurrentResistanceFieldTag.getFieldTagFromInt(fieldTagInt: textField.tag), let fieldText = textField.text else { return }
        viewModel?.onUpdateValue(fieldTag: fieldTag, updatedValue: fieldText)
    }
    
    @objc func didCalculateForSegmentedControlChange(_ segmentedControl: UISegmentedControl) {
        guard let fieldTag = PowerCurrentResistanceFieldTag.getFieldTagFromInt(fieldTagInt: segmentedControl.selectedSegmentIndex) else { return }
        viewModel?.onUpdatedCalculateFor(selectedIndex: segmentedControl.selectedSegmentIndex)
        makeTextFieldAnswerBox(fieldTag: fieldTag)
    }
    
    private func makeTextFieldAnswerBox(fieldTag: PowerCurrentResistanceFieldTag) {
        switch fieldTag {
        case .current:
            makeCurrentFieldAnswerBox()
        case .power:
            makePowerFieldAnswerBox()
        case .resistance:
            makeResistanceFieldAnswerBox()
        }
    }
    
    private func makeCurrentFieldAnswerBox() {
        currentStack.inputField.isAnswerField = true
        powerStack.inputField.isAnswerField = false
        resistanceStack.inputField.isAnswerField = false
    }
    
    private func makePowerFieldAnswerBox() {
        currentStack.inputField.isAnswerField = false
        powerStack.inputField.isAnswerField = true
        resistanceStack.inputField.isAnswerField = false
    }
    
    private func makeResistanceFieldAnswerBox() {
        currentStack.inputField.isAnswerField = false
        powerStack.inputField.isAnswerField = false
        resistanceStack.inputField.isAnswerField = true
    }
}



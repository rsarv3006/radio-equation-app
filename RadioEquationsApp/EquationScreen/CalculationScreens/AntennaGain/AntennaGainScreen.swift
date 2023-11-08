//
//  AntennaGainScreen.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 11/5/23.
//

import Foundation
import UIKit
import Combine
import RichTextView

class AntennaGainScreen: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: AntennaGainViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            viewModel.calculatedValue.sink { calculatedValueObj in
                switch calculatedValueObj.fieldTag {
                case .antennaGain:
                    print("antenna gain")
                    self.antennaGainStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .powerOne:
                    self.powerOneStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .powerTwo:
                    self.powerTwoStack.inputField.text = String(calculatedValueObj.calculatedValue)
                }
            }.store(in: &subscriptions)
            
            switch viewModel.selectedCalculateFor {
            case .antennaGain:
                calculateForSegmentedControl.selectedSegmentIndex = 0
                makeAntennaGainFieldAnswerBox()
            case .powerOne:
                calculateForSegmentedControl.selectedSegmentIndex = 1
                makePowerOneFieldAnswerBox()
            case .powerTwo:
                calculateForSegmentedControl.selectedSegmentIndex = 2
                makePowerTwoFieldAnswerBox()
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
    
    private lazy var calculateForPickerOptions = ["Antenna Gain", "Power 1", "Power 2"]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calculate for:"
        label.textColor = .Theme.textColor
        return label
    }()
    
    private lazy var powerTwoStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: AntennaGainFieldTag.powerTwo.rawValue, fieldLabelText: "Output Power (P2):")
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()
    
    private lazy var antennaGainStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: AntennaGainFieldTag.antennaGain.rawValue, fieldLabelText: "Antenna Gain (Db):")
        stack.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stack
    }()
    
    private lazy var powerOneStack: CalculationFieldStackView = {
        let stack = CalculationFieldStackView(fieldTag: AntennaGainFieldTag.powerOne.rawValue, fieldLabelText: "Input Power (P1):")
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
        
        view.addSubview(antennaGainStack)
        
        antennaGainStack.anchor(top: calculateForSegmentedControl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(powerTwoStack)
        
        powerTwoStack.anchor(top: antennaGainStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        view.addSubview(powerOneStack)
        
        powerOneStack.anchor(top: powerTwoStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
    }
}

extension AntennaGainScreen {
    @objc func didFieldUpdate(_ textField: UITextField) {
        guard let fieldTag = AntennaGainFieldTag.getFieldTagFromInt(fieldTagInt: textField.tag), let fieldText = textField.text else { return }
        viewModel?.onUpdateValue(fieldTag: fieldTag, updatedValue: fieldText)
    }
    
    @objc func didCalculateForSegmentedControlChange(_ segmentedControl: UISegmentedControl) {
        guard let fieldTag = AntennaGainFieldTag.getFieldTagFromInt(fieldTagInt: segmentedControl.selectedSegmentIndex) else { return }
        viewModel?.onUpdatedCalculateFor(selectedIndex: segmentedControl.selectedSegmentIndex)
        makeTextFieldAnswerBox(fieldTag: fieldTag)
    }
    
    private func makeTextFieldAnswerBox(fieldTag: AntennaGainFieldTag) {
        switch fieldTag {
        case .antennaGain:
            makeAntennaGainFieldAnswerBox()
        case .powerOne:
            makePowerOneFieldAnswerBox()
        case .powerTwo:
            makePowerTwoFieldAnswerBox()
        }
    }
    
    private func makeAntennaGainFieldAnswerBox() {
        antennaGainStack.inputField.isAnswerField = true
        powerOneStack.inputField.isAnswerField = false
        powerTwoStack.inputField.isAnswerField = false
    }
    
    private func makePowerOneFieldAnswerBox() {
        antennaGainStack.inputField.isAnswerField = false
        powerOneStack.inputField.isAnswerField = true
        powerTwoStack.inputField.isAnswerField = false
    }
    
    private func makePowerTwoFieldAnswerBox() {
        antennaGainStack.inputField.isAnswerField = false
        powerOneStack.inputField.isAnswerField = false
        powerTwoStack.inputField.isAnswerField = true
    }
}



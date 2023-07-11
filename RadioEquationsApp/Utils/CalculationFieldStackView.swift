//
//  CalculationFieldStack.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/28/23.
//

import UIKit

class CalculationFieldStackView: UIView {
    
    let fieldTag: Int
    
    lazy var fieldLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var inputField: CalculationTextField = {
        let textField = CalculationTextField(fieldTag: fieldTag)
        return textField
    }()
    
    init(fieldTag: Int, fieldLabelText: String) {
        self.fieldTag = fieldTag
        
        super.init(frame: .zero)
        
        fieldLabel.text = fieldLabelText
        inputField.tag = fieldTag
        
        let stackView = UIStackView(arrangedSubviews: [fieldLabel, inputField])
        addSubview(stackView)
        stackView.fillSuperview()
        stackView.axis = .horizontal
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

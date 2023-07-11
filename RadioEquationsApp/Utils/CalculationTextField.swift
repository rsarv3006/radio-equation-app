//
//  CalculationTextField.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/26/23.
//

import UIKit

class CalculationTextField: UITextField {
    var isAnswerField = false {
        didSet {
            if isAnswerField {
                isEnabled = false
                layer.borderColor = UIColor.green.cgColor
            } else {
                isEnabled = true
                layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
    
    init(fieldTag: Int) {
        super.init(frame: .zero)
        borderStyle = .roundedRect
        layer.borderWidth = 1
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = UIColor.lightGray.cgColor
        keyboardType = .decimalPad
        self.tag = fieldTag
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

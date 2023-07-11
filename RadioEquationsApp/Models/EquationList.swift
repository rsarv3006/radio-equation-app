//
//  EquationList.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/19/23.
//

import Foundation

let EquationList: [Equation] = [
    Equation(title: "Ohm's Law", description: "Formula used to calculate voltage in a circuit. E=IxR", id: .ohmsLaw),
    Equation(title: "Power", description: "Formula used to calculate power in watts of a circuit. P=VxI", id: .powerEquation),
    Equation(title: "Test", description: "Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI Formula used to calculate power in watts of a circuit. P=VxI", id: .test),
    
]

struct EquationsTableSectionModel {
    let title: String
    let equations: [Equation]
}

let EquationsTableInfo = [
    EquationsTableSectionModel(title: "Voltage", equations: [
        Equation(title: "E = I X R", description: "Calculate voltage in a circuit", id: .voltage1),
        Equation(title: "E = P / I", description: "Calculate voltage in a circuit", id: .voltage2)
    ])
]

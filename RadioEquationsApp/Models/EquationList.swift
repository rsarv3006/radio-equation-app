//
//  EquationList.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/19/23.
//

import Foundation

struct EquationsTableSectionModel {
    let title: String
    let equations: [Equation]
}

let EquationsTableInfo = [
    EquationsTableSectionModel(title: "Voltage", equations: [
        Equation(title: "[math]$E = I \\times R$[/math]", description: "Calculate voltage in a circuit", id: .voltage1),
        Equation(title: "[math]$E = P / I$[/math]", description: "Calculate voltage in a circuit", id: .voltage2),
        Equation(title: "[math]$E = \\sqrt{P \\times R}$[/math]", description: "Calculate voltage in a circuit", id: .voltage3)
    ]),
    
    EquationsTableSectionModel(title: "Resistance", equations: [
        Equation(title: "[math]$R = E / I$[/math]", description: "Calculate resistance in a circuit.", id: .resistance1),
        Equation(title: "[math]$R = P / I^2$[/math]", description: "Calculate resistance in a circuit.", id: .resistance2),
        Equation(title: "[math]$R = E^2 / P $[/math]", description: "Calculate resistance in a circuit.", id: .resistance3)
    ]),
    
    EquationsTableSectionModel(title: "Current", equations: [
        Equation(title: "[math]$I = E / R$[/math]", description: "Calculate current in a circuit.", id: .current1),
        Equation(title: "[math]$I = P / E$[/math]", description: "Calculate current in a circuit.", id: .current2),
        Equation(title: "[math]$I = \\sqrt{P / R}$[/math]", description: "Calculate current in a circuit.", id: .current3)
    ]),
    
    EquationsTableSectionModel(title: "Power", equations: [
        Equation(title: "[math]$P = E \\times I$[/math]", description: "Calculate power in a circuit.", id: .power1),
        Equation(title: "[math]$P = E^2 / R$[/math]", description: "Calculate power in a circuit.", id: .power2),
        Equation(title: "[math]$P = I^2 \\times R$[/math]", description: "Calculate power in a circuit.", id: .power3)
    ])
]

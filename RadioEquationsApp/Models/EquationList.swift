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

let VoltageCurrentResistanceDescriptionString = """
The equation [math]$E = I \\times R$[/math] represents the relationship between electrical energy (E), current (I), and resistance (R) in an electrical circuit.

Here's a breakdown of each component:

E represents electrical energy and is measured in joules (J) or sometimes in electron volts (eV). It refers to the amount of energy transferred or used by an electrical circuit or device.
I stands for current and is measured in amperes (A). Current refers to the flow of electric charge in a circuit, specifically the rate at which charges move through a conductor.
R represents resistance and is measured in ohms (Ω). Resistance is a property of a circuit element, such as a resistor or a wire, that opposes the flow of electric current.
According to Ohm's Law, the equation [math]$E = I \\times R$[/math] expresses the relationship between these three variables. It states that the electrical energy (E) dissipated or consumed in a circuit is equal to the product of the current (I) flowing through the circuit and the resistance (R) encountered by the current.

In practical terms, this equation can be used to calculate the energy consumption or dissipation in a circuit when the current and resistance values are known. Alternatively, it can be rearranged to solve for other variables. For example, if you know the energy and resistance, you can calculate the current by rearranging the equation as [math]$I = E / R$[/math].
"""

let PowerVoltageCurrentDescriptionString = """
The equation [math]$P = E \\times I$[/math] represents the relationship between power (P), electrical energy (E), and current (I) in an electrical circuit.

Here's a breakdown of each component:

P represents power and is measured in watts (W). Power refers to the rate at which energy is transferred, used, or consumed in a circuit or device.
E represents electrical energy and is measured in joules (J) or sometimes in electron volts (eV). It refers to the amount of energy transferred or used by an electrical circuit or device.
I stands for current and is measured in amperes (A). Current refers to the flow of electric charge in a circuit, specifically the rate at which charges move through a conductor.
The equation [math]$P = E \\times I$[/math] expresses the relationship between these variables. It states that the power (P) in a circuit is equal to the product of the electrical energy (E) and the current (I) flowing through the circuit.

This equation is derived from the definition of power, which is the rate at which energy is transferred. By multiplying the energy transferred (E) by the rate at which it is transferred (I), we obtain the power.

In practical terms, this equation is commonly used to calculate the power consumption or dissipation in a circuit when the energy and current values are known. It can also be rearranged to solve for other variables. For example, if you know the power and current, you can calculate the energy by rearranging the equation as [math]$E = P / I$[/math].
"""

let PowerCurrentResistanceDescriptionString = """
The equation [math]$P = I^2 \\times R$[/math] represents the relationship between power (P), current (I), and resistance (R) in an electrical circuit.

Here's a breakdown of each component:

P represents power and is measured in watts (W). Power refers to the rate at which energy is transferred, used, or consumed in a circuit or device.
I stands for current and is measured in amperes (A). Current refers to the flow of electric charge in a circuit, specifically the rate at which charges move through a conductor.
R represents resistance and is measured in ohms (Ω). Resistance is a property of a circuit element, such as a resistor or a wire, that opposes the flow of electric current.
The equation [math]$P = I^2 \\times R$[/math] expresses the relationship between these variables. It states that the power (P) in a circuit is equal to the square of the current (I) multiplied by the resistance (R) encountered by the current.

This equation is derived from Ohm's Law, which states that the current flowing through a conductor is directly proportional to the voltage across it and inversely proportional to the resistance. By substituting the expression for current from Ohm's Law [math]$(I = V / R)$[/math] into the equation [math]$P = I^2 \\times R$[/math], we can derive the power formula.

In practical terms, this equation is commonly used to calculate the power dissipation in a circuit when the current and resistance values are known. It illustrates that power is directly proportional to the square of the current and the resistance. Therefore, a circuit with higher current or higher resistance will dissipate more power. Conversely, decreasing either the current or resistance will result in lower power dissipation.
"""

let PowerVoltageResistanceDescriptionString = """
The equation [math]$P = E^2 / R$[/math] represents the relationship between power (P), electrical energy (E), and resistance (R) in an electrical circuit.

Here's a breakdown of each component:

P represents power and is measured in watts (W). Power refers to the rate at which energy is transferred, used, or consumed in a circuit or device.
E represents electrical energy and is measured in joules (J) or sometimes in electron volts (eV). It refers to the amount of energy transferred or used by an electrical circuit or device.
R represents resistance and is measured in ohms (Ω). Resistance is a property of a circuit element, such as a resistor or a wire, that opposes the flow of electric current.
The equation [math]$P = E^2 / R$[/math] expresses the relationship between these variables. It states that the power (P) in a circuit is equal to the square of the electrical energy (E) divided by the resistance (R) encountered by the current.

This equation can be derived by combining Ohm's Law [math]$(I = V / R)$[/math] with the power formula [math]$(P = V \\times I)$[/math]. Since voltage (V) can be expressed as [math]$V = E / Q$[/math] (where Q is the charge), and current (I) can be expressed as [math]$I = Q / t$[/math] (where t is time), we can substitute these expressions into the power formula and rearrange to obtain [math]$P = E^2 / R$[/math].

In practical terms, this equation is commonly used to calculate the power dissipation in a circuit when the electrical energy and resistance values are known. It shows that power is inversely proportional to the resistance and that doubling the resistance will halve the power dissipation. Similarly, increasing the electrical energy will result in higher power, assuming the resistance remains constant.
"""


let EquationsTableInfo = [
    EquationsTableSectionModel(title: "Voltage", equations: [
        Equation(title: "[math]$E = I \\times R$[/math]", description: VoltageCurrentResistanceDescriptionString, id: .voltage1, filters: []),
        Equation(title: "[math]$E = P / I$[/math]", description: PowerVoltageCurrentDescriptionString, id: .voltage2, filters: []),
        Equation(title: "[math]$E = \\sqrt{P \\times R}$[/math]", description: PowerVoltageResistanceDescriptionString, id: .voltage3, filters: [.advancedFunctions])
    ]),
    
    EquationsTableSectionModel(title: "Resistance", equations: [
        Equation(title: "[math]$R = E / I$[/math]", description: VoltageCurrentResistanceDescriptionString, id: .resistance1, filters: []),
        Equation(title: "[math]$R = P / I^2$[/math]", description: PowerCurrentResistanceDescriptionString, id: .resistance2, filters: [.advancedFunctions]),
        Equation(title: "[math]$R = E^2 / P $[/math]", description: PowerVoltageResistanceDescriptionString, id: .resistance3, filters: [.advancedFunctions])
    ]),
    
    EquationsTableSectionModel(title: "Current", equations: [
        Equation(title: "[math]$I = E / R$[/math]", description: VoltageCurrentResistanceDescriptionString, id: .current1, filters: []),
        Equation(title: "[math]$I = P / E$[/math]", description: PowerVoltageCurrentDescriptionString, id: .current2, filters: []),
        Equation(title: "[math]$I = \\sqrt{P / R}$[/math]", description: PowerCurrentResistanceDescriptionString, id: .current3, filters: [.advancedFunctions])
    ]),
    
    EquationsTableSectionModel(title: "Power", equations: [
        Equation(title: "[math]$P = E \\times I$[/math]", description: PowerVoltageCurrentDescriptionString, id: .power1, filters: []),
        Equation(title: "[math]$P = E^2 / R$[/math]", description: PowerVoltageResistanceDescriptionString, id: .power2, filters: [.advancedFunctions]),
        Equation(title: "[math]$P = I^2 \\times R$[/math]", description: PowerCurrentResistanceDescriptionString, id: .power3, filters: [.advancedFunctions])
    ]),
    
    EquationsTableSectionModel(title: "Antenna Gain", equations: [
        Equation(title: "[math]$db = 10 \\times log_1_0(P2 / P1)$[/math]", description: "", id: .antennaGain1, filters: []),
        Equation(title: "[math]$P1 = P2 / 10^(^d^b^/^1^0^)$[/math]", description: "", id: .antennaGain2, filters: []),
        Equation(title: "[math]$P2 = P1 \\times 10^(^1^0 ^\\times ^d^b^)$[/math]", description: "", id: .antennaGain3, filters: []),
    ]),
]

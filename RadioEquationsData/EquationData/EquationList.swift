import Foundation

public let EquationsTableInfo = [
    EquationsTableSectionModel(title: "Voltage", equations: [
        Equation(title: "[math]$E = I \\times R$[/math]", description: DescriptionStrings.VoltageCurrentResistance, id: .voltage1, filters: []),
        Equation(title: "[math]$E = P / I$[/math]", description: DescriptionStrings.PowerVoltageCurrent, id: .voltage2, filters: []),
        Equation(title: "[math]$E = \\sqrt{P \\times R}$[/math]", description: DescriptionStrings.PowerVoltageResistance, id: .voltage3, filters: [.advancedFunctions]),
    ]),

    EquationsTableSectionModel(title: "Resistance", equations: [
        Equation(title: "[math]$R = E / I$[/math]", description: DescriptionStrings.VoltageCurrentResistance, id: .resistance1, filters: []),
        Equation(title: "[math]$R = P / I^2$[/math]", description: DescriptionStrings.PowerCurrentResistance, id: .resistance2, filters: [.advancedFunctions]),
        Equation(title: "[math]$R = E^2 / P $[/math]", description: DescriptionStrings.PowerVoltageResistance, id: .resistance3, filters: [.advancedFunctions]),
    ]),

    EquationsTableSectionModel(title: "Current", equations: [
        Equation(title: "[math]$I = E / R$[/math]", description: DescriptionStrings.VoltageCurrentResistance, id: .current1, filters: []),
        Equation(title: "[math]$I = P / E$[/math]", description: DescriptionStrings.PowerVoltageCurrent, id: .current2, filters: []),
        Equation(title: "[math]$I = \\sqrt{P / R}$[/math]", description: DescriptionStrings.PowerCurrentResistance, id: .current3, filters: [.advancedFunctions]),
    ]),

    EquationsTableSectionModel(title: "Power", equations: [
        Equation(title: "[math]$P = E \\times I$[/math]", description: DescriptionStrings.PowerVoltageCurrent, id: .power1, filters: []),
        Equation(title: "[math]$P = E^2 / R$[/math]", description: DescriptionStrings.PowerVoltageResistance, id: .power2, filters: [.advancedFunctions]),
        Equation(title: "[math]$P = I^2 \\times R$[/math]", description: DescriptionStrings.PowerCurrentResistance, id: .power3, filters: [.advancedFunctions]),
    ]),

    EquationsTableSectionModel(title: "Antenna Gain", equations: [
        Equation(title: "[math]$db = 10 \\times log_1_0(P2 / P1)$[/math]", description: DescriptionStrings.AntennaGain, id: .antennaGain1, filters: []),
        Equation(title: "[math]$P1 = P2 / 10^(^d^b^/^1^0^)$[/math]", description: DescriptionStrings.AntennaGain, id: .antennaGain2, filters: [.advancedFunctions]),
        Equation(title: "[math]$P2 = P1 \\times 10^(^1^0 ^\\times ^d^b^)$[/math]", description: DescriptionStrings.AntennaGain, id: .antennaGain3, filters: [.advancedFunctions]),
    ]),

    EquationsTableSectionModel(title: "Impedance (AC) - Reactance", equations: [
        Equation(title: "[math]$Z = \\sqrt{R^2 + (X_L - X_C)^2}$[/math]", description: DescriptionStrings.ImpedanceResistanceReactance, id: .impedance1, filters: []),
        Equation(title: "[math]$R = \\sqrt{Z^2 + (X_L - X_C)^2}$[/math]", description: DescriptionStrings.ImpedanceResistanceReactance, id: .impedance2, filters: [.alternatingCurrentFunctions]),
        Equation(title: "[math]$X_L = \\sqrt{Z^2 - R^2} + X_C$[/math]", description: DescriptionStrings.ImpedanceResistanceReactance, id: .impedance3, filters: [.alternatingCurrentFunctions]),
        Equation(title: "[math]$X_C = X_L - \\sqrt{Z^2 - R^2}$[/math]", description: DescriptionStrings.ImpedanceResistanceReactance, id: .impedance4, filters: [.alternatingCurrentFunctions]),
    ]),

    EquationsTableSectionModel(title: "Apparent Power (AC) - Ohm's Law", equations: [
        Equation(title: "[math]$AP = E \\times I$[/math]", description: DescriptionStrings.ApparentPowerVoltageCurrent, id: .apparentPower1, filters: []),
        Equation(title: "[math]$AP = E^2 \\times Z$[/math]", description: DescriptionStrings.ApparentPowerVoltageImpedance, id: .apparentPower2, filters: [.alternatingCurrentFunctions]),
        Equation(title: "[math]$AP = I^2 \\times Z$[/math]", description: DescriptionStrings.ApparentPowerCurrentImpedance, id: .apparentPower3, filters: [.alternatingCurrentFunctions]),
    ]),

    EquationsTableSectionModel(title: "Voltage (AC) - Ohm's Law", equations: [
        Equation(title: "[math]$E = \\sqrt{AP \\times Z}$[/math]", description: DescriptionStrings.ApparentPowerVoltageImpedance, id: .voltageAC1, filters: []),
        Equation(title: "[math]$E = AP / I$[/math]", description: DescriptionStrings.ApparentPowerVoltageCurrent, id: .voltageAC2, filters: [.alternatingCurrentFunctions]),
        Equation(title: "[math]$E = I \\times Z$[/math]", description: DescriptionStrings.ApparentPowerCurrentImpedance, id: .voltageAC3, filters: [.alternatingCurrentFunctions]),
    ]),

    EquationsTableSectionModel(title: "Impedance (AC) - Ohm's Law", equations: [
        Equation(title: "[math]$Z = E / I$[/math]", description: DescriptionStrings.Impedance, id: .impedance5, filters: []),
        Equation(title: "[math]$Z = E^2 / AP$[/math]", description: DescriptionStrings.Impedance, id: .impedance6, filters: [.alternatingCurrentFunctions]),
        Equation(title: "[math]$Z = AP / I^2$[/math]", description: DescriptionStrings.Impedance, id: .impedance7, filters: [.alternatingCurrentFunctions]),
    ]),

    EquationsTableSectionModel(title: "Current (AC) - Ohm's Law", equations: [
        Equation(title: "[math]$I = E / Z$[/math]", description: DescriptionStrings.VoltageCurrentImpedance, id: .currentAC1, filters: []),
        Equation(title: "[math]$I = \\sqrt{AP / Z}$[/math]", description: DescriptionStrings.ApparentPowerCurrentImpedance, id: .currentAC2, filters: [.alternatingCurrentFunctions]),
        Equation(title: "[math]$I = AP / E$[/math]", description:
                    DescriptionStrings.ApparentPowerVoltageCurrent, id: .currentAC3, filters: [.alternatingCurrentFunctions]),
    ]),
]

import Foundation

enum PickerOptions {
    static let ApparentPowerCurrentImpedance = [
        NSLocalizedString("Apparent Power (AP)", comment: "Picker option for Apparent Power"),
        NSLocalizedString("Current (I)", comment: "Picker option for Current"),
        NSLocalizedString("Impedance (Z)", comment: "Picker option for Impedance")
    ]
    
    static let ApparentPowerVoltageCurrent = [
        NSLocalizedString("Apparent Power (AP)", comment: "Picker option for Apparent Power"),
        NSLocalizedString("Current (I)", comment: "Picker option for Current"),
        NSLocalizedString("Voltage (E)", comment: "Picker option for Voltage")
    ]
    
    static let ApparentPowerVoltageImpedance = [
        NSLocalizedString("Apparent Power (AP)", comment: "Picker option for Apparent Power"),
        NSLocalizedString("Voltage (E)", comment: "Picker option for Voltage"),
        NSLocalizedString("Impedance (Z)", comment: "Picker option for Impedance")
    ]
    
    static let VoltageCurrentImpedance = [
        NSLocalizedString("Voltage (E)", comment: "Picker option for Voltage"),
        NSLocalizedString("Current (I)", comment: "Picker option for Current"),
        NSLocalizedString("Impedance (Z)", comment: "Picker option for Impedance")
    ]
}

public let EquationsTableInfo = [
    EquationsTableSectionModel(title: NSLocalizedString("Voltage", comment: "Title for the Voltage section"), equations: [
        Equation(
            title: NSLocalizedString("[math]$E = I \\times R$[/math]", comment: "Voltage equation: E = I * R"),
            description: DescriptionStrings.VoltageCurrentResistance,
            id: .voltage1,
            filters: [],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$E = P / I$[/math]", comment: "Voltage equation: E = P / I"),
            description: DescriptionStrings.PowerVoltageCurrent,
            id: .voltage2,
            filters: [],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$E = \\sqrt{P \\times R}$[/math]", comment: "Voltage equation: E = sqrt(P * R)"),
            description: DescriptionStrings.PowerVoltageResistance,
            id: .voltage3,
            filters: [.advancedFunctions],
            pickerOptions: []
        ),
    ]),

    EquationsTableSectionModel(title: NSLocalizedString("Resistance", comment: "Title for the Resistance section"), equations: [
        Equation(
            title: NSLocalizedString("[math]$R = E / I$[/math]", comment: "Resistance equation: R = E / I"),
            description: DescriptionStrings.VoltageCurrentResistance,
            id: .resistance1,
            filters: [],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$R = P / I^2$[/math]", comment: "Resistance equation: R = P / I^2"),
            description: DescriptionStrings.PowerCurrentResistance,
            id: .resistance2,
            filters: [.advancedFunctions],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$R = E^2 / P $[/math]", comment: "Resistance equation: R = E^2 / P"),
            description: DescriptionStrings.PowerVoltageResistance,
            id: .resistance3,
            filters: [.advancedFunctions],
            pickerOptions: []
        ),
    ]),

    EquationsTableSectionModel(title: NSLocalizedString("Current", comment: "Title for the Current section"), equations: [
        Equation(
            title: NSLocalizedString("[math]$I = E / R$[/math]", comment: "Current equation: I = E / R"),
            description: DescriptionStrings.VoltageCurrentResistance,
            id: .current1,
            filters: [],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$I = P / E$[/math]", comment: "Current equation: I = P / E"),
            description: DescriptionStrings.PowerVoltageCurrent,
            id: .current2,
            filters: [],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$I = \\sqrt{P / R}$[/math]", comment: "Current equation: I = sqrt(P / R)"),
            description: DescriptionStrings.PowerCurrentResistance,
            id: .current3,
            filters: [.advancedFunctions],
            pickerOptions: []
        ),
    ]),

    EquationsTableSectionModel(title: NSLocalizedString("Power", comment: "Title for the Power section"), equations: [
        Equation(
            title: NSLocalizedString("[math]$P = E \\times I$[/math]", comment: "Power equation: P = E * I"),
            description: DescriptionStrings.PowerVoltageCurrent,
            id: .power1,
            filters: [],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$P = E^2 / R$[/math]", comment: "Power equation: P = E^2 / R"),
            description: DescriptionStrings.PowerVoltageResistance,
            id: .power2,
            filters: [.advancedFunctions],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$P = I^2 \\times R$[/math]", comment: "Power equation: P = I^2 * R"),
            description: DescriptionStrings.PowerCurrentResistance,
            id: .power3,
            filters: [.advancedFunctions],
            pickerOptions: []
        ),
    ]),

    EquationsTableSectionModel(title: NSLocalizedString("Antenna Gain", comment: "Title for the Antenna Gain section"), equations: [
        Equation(
            title: NSLocalizedString("[math]$db = 10 \\times log_1_0(P2 / P1)$[/math]", comment: "Antenna Gain equation: db = 10 * log10(P2 / P1)"),
            description: DescriptionStrings.AntennaGain,
            id: .antennaGain1,
            filters: [],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$P1 = P2 / 10^(^d^b^/^1^0^)$[/math]", comment: "Antenna Gain equation: P1 = P2 / 10^(db/10)"),
            description: DescriptionStrings.AntennaGain,
            id: .antennaGain2,
            filters: [.advancedFunctions],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$P2 = P1 \\times 10^(^1^0 ^\\times ^d^b^)$[/math]", comment: "Antenna Gain equation: P2 = P1 * 10^(10 * db)"),
            description: DescriptionStrings.AntennaGain,
            id: .antennaGain3,
            filters: [.advancedFunctions],
            pickerOptions: []
        ),
    ]),

    EquationsTableSectionModel(title: NSLocalizedString("Impedance (AC) - Reactance", comment: "Title for the Impedance (AC) - Reactance section"), equations: [
        Equation(
            title: NSLocalizedString("[math]$Z = \\sqrt{R^2 + (X_L - X_C)^2}$[/math]", comment: "Impedance equation: Z = sqrt(R^2 + (XL - XC)^2)"),
            description: DescriptionStrings.ImpedanceResistanceReactance,
            id: .impedance1,
            filters: [],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$R = \\sqrt{Z^2 + (X_L - X_C)^2}$[/math]", comment: "Impedance equation: R = sqrt(Z^2 + (XL - XC)^2)"),
            description: DescriptionStrings.ImpedanceResistanceReactance,
            id: .impedance2,
            filters: [.alternatingCurrentFunctions],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$X_L = \\sqrt{Z^2 - R^2} + X_C$[/math]", comment: "Impedance equation: XL = sqrt(Z^2 - R^2) + XC"),
            description: DescriptionStrings.ImpedanceResistanceReactance,
            id: .impedance3,
            filters: [.alternatingCurrentFunctions],
            pickerOptions: []
        ),
        Equation(
            title: NSLocalizedString("[math]$X_C = X_L - \\sqrt{Z^2 - R^2}$[/math]", comment: "Impedance equation: XC = XL - sqrt(Z^2 - R^2)"),
            description: DescriptionStrings.ImpedanceResistanceReactance,
            id: .impedance4,
            filters: [.alternatingCurrentFunctions],
            pickerOptions: []
        ),
    ]),

    EquationsTableSectionModel(title: NSLocalizedString("Apparent Power (AC) - Ohm's Law", comment: "Title for the Apparent Power (AC) - Ohm's Law section"), equations: [
        Equation(
            title: NSLocalizedString("[math]$AP = E \\times I$[/math]", comment: "Apparent Power equation: AP = E * I"),
            description: DescriptionStrings.ApparentPowerVoltageCurrent,
            id: .apparentPower1,
            filters: [],
            pickerOptions: PickerOptions.ApparentPowerVoltageCurrent
        ),
        Equation(
            title: NSLocalizedString("[math]$AP = E^2 / Z$[/math]", comment: "Apparent Power equation: AP = E^2 / Z"),
            description: DescriptionStrings.ApparentPowerVoltageImpedance,
            id: .apparentPower2,
            filters: [.alternatingCurrentFunctions],
            pickerOptions: PickerOptions.ApparentPowerVoltageImpedance
        ),
        Equation(
            title: NSLocalizedString("[math]$AP = I^2 \\times Z$[/math]", comment: "Apparent Power equation: AP = I^2 * Z"),
            description: DescriptionStrings.ApparentPowerCurrentImpedance,
            id: .apparentPower3,
            filters: [.alternatingCurrentFunctions],
            pickerOptions: PickerOptions.ApparentPowerCurrentImpedance
        ),
    ]),

    EquationsTableSectionModel(title: NSLocalizedString("Voltage (AC) - Ohm's Law", comment: "Title for the Voltage (AC) - Ohm's Law section"), equations: [
        Equation(
            title: NSLocalizedString("[math]$E = \\sqrt{AP \\times Z}$[/math]", comment: "Voltage equation: E = sqrt(AP * Z)"),
            description: DescriptionStrings.ApparentPowerVoltageImpedance,
            id: .voltageAC1,
            filters: [],
            pickerOptions: PickerOptions.ApparentPowerVoltageImpedance
        ),
        Equation(
            title: NSLocalizedString("[math]$E = AP / I$[/math]", comment: "Voltage equation: E = AP / I"),
            description: DescriptionStrings.ApparentPowerVoltageCurrent,
            id: .voltageAC2,
            filters: [.alternatingCurrentFunctions],
            pickerOptions: PickerOptions.ApparentPowerVoltageCurrent
        ),
        Equation(
            title: NSLocalizedString("[math]$E = I \\times Z$[/math]", comment: "Voltage equation: E = I * Z"),
            description: DescriptionStrings.VoltageCurrentImpedance,
            id: .voltageAC3,
            filters: [.alternatingCurrentFunctions],
            pickerOptions: PickerOptions.VoltageCurrentImpedance
        ),
    ]),

    EquationsTableSectionModel(title: NSLocalizedString("Impedance (AC) - Ohm's Law", comment: "Title for the Impedance (AC) - Ohm's Law section"), equations: [
        Equation(
            title: NSLocalizedString("[math]$Z = E / I$[/math]", comment: "Impedance equation: Z = E / I"),
            description: DescriptionStrings.Impedance,
            id: .impedance5,
            filters: [],
            pickerOptions: PickerOptions.VoltageCurrentImpedance
        ),
        Equation(
            title: NSLocalizedString("[math]$Z = E^2 / AP$[/math]", comment: "Impedance equation: Z = E^2 / AP"),
            description: DescriptionStrings.Impedance,
            id: .impedance6,
            filters: [.alternatingCurrentFunctions],
            pickerOptions: PickerOptions.ApparentPowerVoltageImpedance
        ),
        Equation(
            title: NSLocalizedString("[math]$Z = AP / I^2$[/math]", comment: "Impedance equation: Z = AP / I^2"),
            description: DescriptionStrings.Impedance,
            id: .impedance7,
            filters: [.alternatingCurrentFunctions],
            pickerOptions: PickerOptions.ApparentPowerCurrentImpedance
        ),
    ]),

    EquationsTableSectionModel(title: NSLocalizedString("Current (AC) - Ohm's Law", comment: "Title for the Current (AC) - Ohm's Law section"), equations: [
        Equation(
            title: NSLocalizedString("[math]$I = E / Z$[/math]", comment: "Current equation: I = E / Z"),
            description: DescriptionStrings.VoltageCurrentImpedance,
            id: .currentAC1,
            filters: [],
            pickerOptions: PickerOptions.VoltageCurrentImpedance
        ),
        Equation(
            title: NSLocalizedString("[math]$I = \\sqrt{AP / Z}$[/math]", comment: "Current equation: I = sqrt(AP / Z)"),
            description: DescriptionStrings.ApparentPowerCurrentImpedance,
            id: .currentAC2,
            filters: [.alternatingCurrentFunctions],
            pickerOptions: PickerOptions.ApparentPowerCurrentImpedance
        ),
        Equation(
            title: NSLocalizedString("[math]$I = AP / E$[/math]", comment: "Current equation: I = AP / E"),
            description: DescriptionStrings.ApparentPowerVoltageCurrent,
            id: .currentAC3,
            filters: [.alternatingCurrentFunctions],
            pickerOptions: PickerOptions.ApparentPowerVoltageCurrent
        ),
    ]),
]

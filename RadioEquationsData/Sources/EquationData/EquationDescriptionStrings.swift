import Foundation

public enum DescriptionStrings {
    static let VoltageCurrentResistance = NSLocalizedString("""
    The equation [math]$E = I \\times R$[/math] represents the relationship between electrical energy (E), current (I), and resistance (R) in an electrical circuit.

    Here's a breakdown of each component:

    E represents electrical energy and is measured in joules (J) or sometimes in electron volts (eV). It refers to the amount of energy transferred or used by an electrical circuit or device.
    I stands for current and is measured in amperes (A). Current refers to the flow of electric charge in a circuit, specifically the rate at which charges move through a conductor.
    R represents resistance and is measured in ohms (Ω). Resistance is a property of a circuit element, such as a resistor or a wire, that opposes the flow of electric current.
    According to Ohm's Law, the equation [math]$E = I \\times R$[/math] expresses the relationship between these three variables. It states that the electrical energy (E) dissipated or consumed in a circuit is equal to the product of the current (I) flowing through the circuit and the resistance (R) encountered by the current.

    In practical terms, this equation can be used to calculate the energy consumption or dissipation in a circuit when the current and resistance values are known. Alternatively, it can be rearranged to solve for other variables. For example, if you know the energy and resistance, you can calculate the current by rearranging the equation as [math]$I = E / R$[/math].
    """, comment: "VoltageCurrentResistance description")

    static let PowerVoltageCurrent = NSLocalizedString("""
    The equation [math]$P = E \\times I$[/math] represents the relationship between power (P), electrical energy (E), and current (I) in an electrical circuit.

    Here's a breakdown of each component:

    P represents power and is measured in watts (W). Power refers to the rate at which energy is transferred, used, or consumed in a circuit or device.
    E represents electrical energy and is measured in joules (J) or sometimes in electron volts (eV). It refers to the amount of energy transferred or used by an electrical circuit or device.
    I stands for current and is measured in amperes (A). Current refers to the flow of electric charge in a circuit, specifically the rate at which charges move through a conductor.
    The equation [math]$P = E \\times I$[/math] expresses the relationship between these variables. It states that the power (P) in a circuit is equal to the product of the electrical energy (E) and the current (I) flowing through the circuit.

    This equation is derived from the definition of power, which is the rate at which energy is transferred. By multiplying the energy transferred (E) by the rate at which it is transferred (I), we obtain the power.

    In practical terms, this equation is commonly used to calculate the power consumption or dissipation in a circuit when the energy and current values are known. It can also be rearranged to solve for other variables. For example, if you know the power and current, you can calculate the energy by rearranging the equation as [math]$E = P / I$[/math].
    """, comment: "equation description")

    static let PowerCurrentResistance = NSLocalizedString("""
    The equation [math]$P = I^2 \\times R$[/math] represents the relationship between power (P), current (I), and resistance (R) in an electrical circuit.

    Here's a breakdown of each component:

    P represents power and is measured in watts (W). Power refers to the rate at which energy is transferred, used, or consumed in a circuit or device.
    I stands for current and is measured in amperes (A). Current refers to the flow of electric charge in a circuit, specifically the rate at which charges move through a conductor.
    R represents resistance and is measured in ohms (Ω). Resistance is a property of a circuit element, such as a resistor or a wire, that opposes the flow of electric current.
    The equation [math]$P = I^2 \\times R$[/math] expresses the relationship between these variables. It states that the power (P) in a circuit is equal to the square of the current (I) multiplied by the resistance (R) encountered by the current.

    This equation is derived from Ohm's Law, which states that the current flowing through a conductor is directly proportional to the voltage across it and inversely proportional to the resistance. By substituting the expression for current from Ohm's Law [math]$(I = V / R)$[/math] into the equation [math]$P = I^2 \\times R$[/math], we can derive the power formula.

    In practical terms, this equation is commonly used to calculate the power dissipation in a circuit when the current and resistance values are known. It illustrates that power is directly proportional to the square of the current and the resistance. Therefore, a circuit with higher current or higher resistance will dissipate more power. Conversely, decreasing either the current or resistance will result in lower power dissipation.
    """, comment: "equation description")

    static let PowerVoltageResistance = NSLocalizedString("""
    The equation [math]$P = E^2 / R$[/math] represents the relationship between power (P), electrical energy (E), and resistance (R) in an electrical circuit.

    Here's a breakdown of each component:

    P represents power and is measured in watts (W). Power refers to the rate at which energy is transferred, used, or consumed in a circuit or device.
    E represents electrical energy and is measured in joules (J) or sometimes in electron volts (eV). It refers to the amount of energy transferred or used by an electrical circuit or device.
    R represents resistance and is measured in ohms (Ω). Resistance is a property of a circuit element, such as a resistor or a wire, that opposes the flow of electric current.
    The equation [math]$P = E^2 / R$[/math] expresses the relationship between these variables. It states that the power (P) in a circuit is equal to the square of the electrical energy (E) divided by the resistance (R) encountered by the current.

    This equation can be derived by combining Ohm's Law [math]$(I = V / R)$[/math] with the power formula [math]$(P = V \\times I)$[/math]. Since voltage (V) can be expressed as [math]$V = E / Q$[/math] (where Q is the charge), and current (I) can be expressed as [math]$I = Q / t$[/math] (where t is time), we can substitute these expressions into the power formula and rearrange to obtain [math]$P = E^2 / R$[/math].

    In practical terms, this equation is commonly used to calculate the power dissipation in a circuit when the electrical energy and resistance values are known. It shows that power is inversely proportional to the resistance and that doubling the resistance will halve the power dissipation. Similarly, increasing the electrical energy will result in higher power, assuming the resistance remains constant.
    """, comment: "equation description")

    static let AntennaGain = NSLocalizedString("""
    The antenna gain equation calculates the gain of an antenna in decibels (dB). The gain represents how much an antenna concentrates radio frequency energy in a particular direction, if the antenna is a non-omnidirectional antenna.  If it is an omni-directional antenna, then the gain or main-lobe of the radio frequency energy is assumed to radiate in a 360-degree pattern, as in a sphere-shaped pattern.

    The formula is:

    [math]$antenna gain (in db)[/math]


    [math]= 10 \\times log_1_0(P2 / P1)$[/math]

    Where:

    Output power is the power radiated by the antenna in the direction of peak radiation intensity. This is measured in watts (W).
    Input power is the power supplied to the antenna at its input terminals. This is also measured in watts.
    log10 is the base-10 logarithm function.
    10 is a constant factor to convert the logarithmic value to decibels.
    The ratio of output power to input power gives the power gain of the antenna. Taking the logarithm of this ratio gives the gain in absolute units. Multiplying by 10 converts this to decibels, which is the standard unit used to express antenna gain.

    So in summary, this formula takes the ratio of output to input power, takes the logarithm to get the absolute gain, and then converts to decibels to calculate the total antenna gain. The higher the gain in dB, the more intense the antenna radiation is in a particular direction (if a non-omnidirectional antenna) or not (if an omnidirectional antenna.)
    """, comment: "equation description")

    static let ImpedanceResistanceReactance = NSLocalizedString("""
    The impedance of an electrical circuit is a measure of the opposition to the flow of alternating current (AC) through the circuit.

    It consists of two components: resistance (R) and reactance (X), which can be inductive [math]$X_L$[/math] or capacitive [math]$X_C$[/math].

    The total impedance (Z) is the vector sum of the resistance and reactance components.


    Frequency is measured in hertz (Hz), also known as cycles per second.

    Inductance is measured in henrys. 

    Capacitance is measured in farads.


    [math]$X_L$[/math] - is Inductive Reactance and is measured in ohms

    [math]$X_C$[/math] - is Capacitive Reactance and is measured in ohms


    Note due to the nature of this equation, it is possible to have a result of 'nan' (not a number) if the reactance components are equal. This is because the square root of a negative number is not a real number.
    """, comment: "equation description")

    static let ApparentPowerVoltageCurrent = NSLocalizedString("""
    The equation [math]$AP = E \\times I$[/math] represents the relationship between apparent power (AP), electrical energy (E), and current (I) in an electrical circuit.

    Here's a breakdown of each component:

    AP represents apparent power and is measured in watts (W), sometimes shown as volt-amps (VA). Apparent power refers to the power that is perceived by the circuit or device, taking into account the presence of reactive components such as inductance and capacitance.
    E represents electrical energy and is measured in joules (J) or sometimes in electron volts (eV). It refers to the amount of energy transferred or used by an electrical circuit or device.
    I stands for current and is measured in amperes (A). Current refers to the flow of electric charge in a circuit, specifically the rate at which charges move through a conductor.
    The equation [math]$AP = E \\times I$[/math] expresses the relationship between these variables. It states that the apparent power (AP) in a circuit is equal to the product of the electrical energy (E) and the current (I) flowing through the circuit.

    In practical terms, this equation is commonly used to calculate the apparent power in a circuit when the energy and current values are known. It can also be rearranged to solve for other variables. For example, if you know the apparent power and current, you can calculate the energy by rearranging the equation as [math]$E = AP / I$[/math].

    E is electrical voltage potential in volts. 

    I is the flow of electrons in amperes. Current flows from the point of highest potential (negative) to the point of lowest potential (positive) 

    R is resistance to the flow of current in ohms. 

    Z is impedance to the flow of alternating current in ohms. 

    P is electrical power to do work in watts 
    """, comment: "equation description")

    static let ApparentPowerVoltageImpedance = NSLocalizedString("""
    The equation [math]$AP = E^2 / Z$[/math] represents the relationship between apparent power (AP), electrical energy (E), and impedance (Z) in an electrical circuit.

    Here's a breakdown of each component:

    AP represents apparent power and is measured in watts (W), sometimes shown as volt-amps (VA). Apparent power refers to the power that is perceived by the circuit or device, taking into account the presence of reactive components such as inductance and capacitance.
    E represents electrical energy and is measured in joules (J) or sometimes in electron volts (eV). It refers to the amount of energy transferred or used by an electrical circuit or device.
    Z represents impedance and is measured in ohms (Ω). Impedance is a property of a circuit element, such as a resistor or a wire, that opposes the flow of electric current.
    The equation [math]$AP = E^2 / Z$[/math] expresses the relationship between these variables. It states that the apparent power (AP) in a circuit is equal to the square of the electrical energy (E) divided by the impedance (Z) encountered by the current.

    In practical terms, this equation is commonly used to calculate the apparent power in a circuit when the energy and impedance values are known. It can also be rearranged to solve for other variables. For example, if you know the apparent power and impedance, you can calculate the energy by rearranging the equation as [math]$E = AP / Z$[/math].

    E is electrical voltage potential in volts. 

    I is the flow of electrons in amperes. Current flows from the point of highest potential (negative) to the point of lowest potential (positive) 

    R is resistance to the flow of current in ohms. 

    Z is impedance to the flow of alternating current in ohms. 

    P is electrical power to do work in watts 
    """, comment: "equation description")

    static let ApparentPowerCurrentImpedance = NSLocalizedString("""
    The equation [math]$AP = I^2 \\times Z$[/math] represents the relationship between apparent power (AP), current (I), and impedance (Z) in an electrical circuit.

    Here's a breakdown of each component:

    AP represents apparent power and is measured in watts (W), sometimes shown as volt-amps (VA). Apparent power refers to the power that is perceived by the circuit or device, taking into account the presence of reactive components such as inductance and capacitance.
    I stands for current and is measured in amperes (A). Current refers to the flow of electric charge in a circuit, specifically the rate at which charges move through a conductor.
    Z represents impedance and is measured in ohms (Ω). Impedance is a property of a circuit element, such as a resistor or a wire, that opposes the flow of electric current.
    The equation [math]$AP = I^2 \\times Z$[/math] expresses the relationship between these variables. It states that the apparent power (AP) in a circuit is equal to the square of the current (I) multiplied by the impedance (Z) encountered by the current.

    In practical terms, this equation is commonly used to calculate the apparent power in a circuit when the current and impedance values are known. It can also be rearranged to solve for other variables. For example, if you know the apparent power and impedance, you can calculate the current by rearranging the equation as [math]$I = AP / Z$[/math].

    E is electrical voltage potential in volts. 

    I is the flow of electrons in amperes. Current flows from the point of highest potential (negative) to the point of lowest potential (positive) 

    R is resistance to the flow of current in ohms. 

    Z is impedance to the flow of alternating current in ohms. 

    P is electrical power to do work in watts 
    """, comment: "equation description")

    static let VoltageCurrentImpedance = NSLocalizedString("""
    The equation [math]$E = I \\times Z$[/math] represents the relationship between electrical energy (E), current (I), and impedance (Z) in an electrical circuit.

    Here's a breakdown of each component:

    E represents electrical energy and is measured in joules (J) or sometimes in electron volts (eV). It refers to the amount of energy transferred or used by an electrical circuit or device.
    I stands for current and is measured in amperes (A). Current refers to the flow of electric charge in a circuit, specifically the rate at which charges move through a conductor.
    Z represents impedance and is measured in ohms (Ω). Impedance is a property of a circuit element, such as a resistor or a wire, that opposes the flow of electric current.
    The equation [math]$E = I \\times Z$[/math] expresses the relationship between these variables. It states that the electrical energy (E) in a circuit is equal to the product of the current (I) flowing through the circuit and the impedance (Z) encountered by the current.

    In practical terms, this equation is commonly used to calculate the energy in a circuit when the current and impedance values are known. It can also be rearranged to solve for other variables. For example, if you know the energy and impedance, you can calculate the current by rearranging the equation as [math]$I = E / Z$[/math].

    E is electrical voltage potential in volts. 

    I is the flow of electrons in amperes. Current flows from the point of highest potential (negative) to the point of lowest potential (positive) 

    R is resistance to the flow of current in ohms. 

    Z is impedance to the flow of alternating current in ohms. 

    P is electrical power to do work in watts 

    AP is Apparent Power and is measured in units of Volt-Amps (VA).
    """, comment: "equation description")

    static let Impedance = NSLocalizedString("""
    The equation [math]$Z = E / I$[/math] represents the relationship between impedance (Z), electrical energy (E), and current (I) in an electrical circuit.

    Here's a breakdown of each component:

    Z represents impedance and is measured in ohms (Ω). Impedance is a property of a circuit element, such as a resistor or a wire, that opposes the flow of electric current.
    E represents electrical energy and is measured in joules (J) or sometimes in electron volts (eV). It refers to the amount of energy transferred or used by an electrical circuit or device.
    I stands for current and is measured in amperes (A). Current refers to the flow of electric charge in a circuit, specifically the rate at which charges move through a conductor.
    The equation [math]$Z = E / I$[/math] expresses the relationship between these variables. It states that the impedance (Z) in a circuit is equal to the product of the electrical energy (E) and the current (I) flowing through the circuit.

    In practical terms, this equation is commonly used to calculate the impedance in a circuit when the energy and current values are known. It can also be rearranged to solve for other variables. For example, if you know the impedance and current, you can calculate the energy by rearranging the equation as [math]$E = Z * I$[/math].

    E is electrical voltage potential in volts. 

    I is the flow of electrons in amperes. Current flows from the point of highest potential (negative) to the point of lowest potential (positive) 

    R is resistance to the flow of current in ohms. 

    Z is impedance to the flow of alternating current in ohms. 

    P is electrical power to do work in watts 

    AP is Apparent Power and is measured in units of Volt-Amps (VA).
    """, comment: "equation description")
}

import RadioEquationsData
import UIKit

class EquationScreenTabBar: UITabBarController {
    private var viewModel: EquationScreenTabBarViewModel?

    init(viewModel: EquationScreenTabBarViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let equation = viewModel?.equation else { return }

        let descriptionVC = DescriptionTab()
        descriptionVC.viewModel = DescriptionTabViewModel(equation: equation)
        descriptionVC.title = NSLocalizedString("Description", comment: "Title for Description tab")
        let descriptionTabBarItem = UITabBarItem(title: NSLocalizedString("Description", comment: "Title for Description tab in tab bar"), image: UIImage(systemName: "doc.plaintext")?.withTintColor(.Theme.altColor, renderingMode: .alwaysOriginal), tag: 0)
        descriptionVC.tabBarItem = descriptionTabBarItem

        let equationVC = createEquationCalculationScreen()
        equationVC.title = NSLocalizedString("Equation", comment: "Title for Equation tab")
        let equationTabBarItem = UITabBarItem(title: NSLocalizedString("Equation", comment: "Title for Equation tab in tab bar"), image: UIImage(systemName: "function")?.withTintColor(.Theme.altColor, renderingMode: .alwaysOriginal), tag: 1)
        equationVC.tabBarItem = equationTabBarItem

        viewControllers = [equationVC, descriptionVC]
    }

    private func createEquationCalculationScreen() -> UIViewController {
        if let equation = viewModel?.equation, let equationId = viewModel?.equation.id {
            switch equationId {
            case .voltage1:
                let vm = ResistanceCurrentVoltageViewModel(equation: equation, calculateFor: .voltage)
                let screen = ResistanceCurrentVoltageScreen()
                screen.viewModel = vm
                return screen
            case .resistance1:
                let vm = ResistanceCurrentVoltageViewModel(equation: equation, calculateFor: .resistance)
                let screen = ResistanceCurrentVoltageScreen()
                screen.viewModel = vm
                return screen
            case .current1:
                let vm = ResistanceCurrentVoltageViewModel(equation: equation, calculateFor: .current)
                let screen = ResistanceCurrentVoltageScreen()
                screen.viewModel = vm
                return screen
            case .voltage2:
                let powerVm = PowerVoltageCurrentViewModel(equation: equation, calculateFor: .voltage)
                let powerScreen = PowerVoltageCurrentScreen()
                powerScreen.viewModel = powerVm
                return powerScreen
            case .current2:
                let powerVm = PowerVoltageCurrentViewModel(equation: equation, calculateFor: .current)
                let powerScreen = PowerVoltageCurrentScreen()
                powerScreen.viewModel = powerVm
                return powerScreen
            case .power1:
                let powerVm = PowerVoltageCurrentViewModel(equation: equation, calculateFor: .power)
                let powerScreen = PowerVoltageCurrentScreen()
                powerScreen.viewModel = powerVm
                return powerScreen
            case .resistance2:
                let vm = PowerCurrentResistanceViewModel(equation: equation, calculateFor: .resistance)
                let screen = PowerCurrentResistanceScreen()
                screen.viewModel = vm
                return screen
            case .power3:
                let vm = PowerCurrentResistanceViewModel(equation: equation, calculateFor: .power)
                let screen = PowerCurrentResistanceScreen()
                screen.viewModel = vm
                return screen
            case .current3:
                let vm = PowerCurrentResistanceViewModel(equation: equation, calculateFor: .current)
                let screen = PowerCurrentResistanceScreen()
                screen.viewModel = vm
                return screen
            case .voltage3:
                let vm = VoltagePowerResistanceViewModel(equation: equation, calculateFor: .voltage)
                let screen = VoltagePowerResistanceScreen()
                screen.viewModel = vm
                return screen
            case .resistance3:
                let vm = VoltagePowerResistanceViewModel(equation: equation, calculateFor: .resistance)
                let screen = VoltagePowerResistanceScreen()
                screen.viewModel = vm
                return screen
            case .power2:
                let vm = VoltagePowerResistanceViewModel(equation: equation, calculateFor: .power)
                let screen = VoltagePowerResistanceScreen()
                screen.viewModel = vm
                return screen
            case .antennaGain1:
                let vm = AntennaGainViewModel(equation: equation, calculateFor: .antennaGain)
                let screen = AntennaGainScreen()
                screen.viewModel = vm
                return screen
            case .antennaGain2:
                let vm = AntennaGainViewModel(equation: equation, calculateFor: .powerOne)
                let screen = AntennaGainScreen()
                screen.viewModel = vm
                return screen
            case .antennaGain3:
                let vm = AntennaGainViewModel(equation: equation, calculateFor: .powerTwo)
                let screen = AntennaGainScreen()
                screen.viewModel = vm
                return screen
            case .impedance1:
                let vm = ImpedanceViewModel(equation: equation, calculateFor: .impedance)
                let screen = ImpedanceScreen()
                screen.viewModel = vm
                return screen
            case .impedance2:
                let vm = ImpedanceViewModel(equation: equation, calculateFor: .resistance)
                let screen = ImpedanceScreen()
                screen.viewModel = vm
                return screen
            case .impedance3:
                let vm = ImpedanceViewModel(equation: equation, calculateFor: .inductiveReactance)
                let screen = ImpedanceScreen()
                screen.viewModel = vm
                return screen
            case .impedance4:
                let vm = ImpedanceViewModel(equation: equation, calculateFor: .capacitiveReactance)
                let screen = ImpedanceScreen()
                screen.viewModel = vm
                return screen
            case .apparentPower1:
                let vm = SharedCalculationViewModel(
                    equation: equation,
                    calculateFor: .fieldOne,
                    calculationUtils: ApparentPowerCurrentVoltageUtils()
                )
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            case .apparentPower2:
                let vm = SharedCalculationViewModel(
                    equation: equation,
                    calculateFor: .fieldOne,
                    calculationUtils: ApparentPowerVoltageImpedanceUtils()
                )
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            case .apparentPower3:
                let vm = SharedCalculationViewModel(
                    equation: equation,
                    calculateFor: .fieldOne,
                    calculationUtils: ApparentPowerCurrentImpedanceUtils()
                )
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            case .voltageAC1:
                let vm = SharedCalculationViewModel(
                    equation: equation,
                    calculateFor: .fieldTwo,
                    calculationUtils: ApparentPowerVoltageImpedanceUtils()
                )
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            case .voltageAC2:
                let vm = SharedCalculationViewModel(equation: equation, calculateFor: .fieldThree, calculationUtils: ApparentPowerCurrentVoltageUtils())
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            case .voltageAC3:
                let vm = SharedCalculationViewModel(
                    equation: equation,
                    calculateFor: .fieldOne,
                    calculationUtils: VoltageCurrentImpedanceUtils()
                )
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            case .currentAC1:
                let vm = SharedCalculationViewModel(
                    equation: equation,
                    calculateFor: .fieldTwo,
                    calculationUtils: VoltageCurrentImpedanceUtils()
                )
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            case .currentAC2:
                let vm = SharedCalculationViewModel(
                    equation: equation,
                    calculateFor: .fieldTwo,
                    calculationUtils: ApparentPowerCurrentImpedanceUtils()
                )
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            case .currentAC3:
                let vm = SharedCalculationViewModel(equation: equation, calculateFor: .fieldTwo, calculationUtils: ApparentPowerCurrentVoltageUtils())
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            case .impedance5:
                let vm = SharedCalculationViewModel(
                    equation: equation,
                    calculateFor: .fieldThree,
                    calculationUtils: VoltageCurrentImpedanceUtils()
                )
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            case .impedance6:
                let vm = SharedCalculationViewModel(
                    equation: equation,
                    calculateFor: .fieldThree,
                    calculationUtils: ApparentPowerVoltageImpedanceUtils()
                )
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            case .impedance7:
                let vm = SharedCalculationViewModel(
                    equation: equation,
                    calculateFor: .fieldThree,
                    calculationUtils: ApparentPowerCurrentImpedanceUtils()
                )
                let screen = SharedCalculationScreen()
                screen.viewModel = vm
                return screen
            default:
                return EquationTab()
            }
        } else {
            return EquationTab()
        }
    }
}

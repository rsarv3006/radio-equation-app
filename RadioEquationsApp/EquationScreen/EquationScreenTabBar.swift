import UIKit

class EquationScreenTabBar: UITabBarController {
    
    private var viewModel: EquationScreenTabBarViewModel?
    
    init(viewModel: EquationScreenTabBarViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let equation = viewModel?.equation else { return }
        
        let descriptionVC = DescriptionTab()
        descriptionVC.viewModel = DescriptionTabViewModel(equation: equation)
        descriptionVC.title = "Description"
        let descriptionTabBarItem = UITabBarItem(title: "Description", image: UIImage(systemName: "doc.plaintext")?.withTintColor(.Theme.altColor, renderingMode: .alwaysOriginal), tag: 0)
        descriptionVC.tabBarItem = descriptionTabBarItem
        
        let equationVC = createEquationCalculationScreen()
        equationVC.title = "Equation"
        let equationTabBarItem = UITabBarItem(title: "Equation", image: UIImage(systemName: "function")?.withTintColor(.Theme.altColor, renderingMode: .alwaysOriginal), tag: 1)
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
            default:
                return EquationTab()
            
            
            }
        } else {
            return EquationTab()
        }
    }

}

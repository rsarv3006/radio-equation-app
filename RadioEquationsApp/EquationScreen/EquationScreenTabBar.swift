//
//  EquationScreen.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/17/23.
//

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
        let descriptionTabBarItem = UITabBarItem(title: "Description", image: UIImage(systemName: "doc.plaintext"), tag: 0)
        descriptionVC.tabBarItem = descriptionTabBarItem
        
        let equationVC = createEquationCalculationScreen()
        equationVC.title = "Equation"
        let equationTabBarItem = UITabBarItem(title: "Equation", image: UIImage(systemName: "function"), tag: 1)
        equationVC.tabBarItem = equationTabBarItem
        
        viewControllers = [descriptionVC, equationVC]
    }
    
    private func createEquationCalculationScreen() -> UIViewController {
        if let equationId = viewModel?.equation.id {
            switch equationId {
            case .ohmsLaw:
                let ohmsLawCalculationViewModel = OhmsLawCalculationScreenViewModel()
                let ohmsLawCalculationScreen = OhmsLawCalculationScreen()
                ohmsLawCalculationScreen.viewModel = ohmsLawCalculationViewModel
                return ohmsLawCalculationScreen
            case .powerEquation:
                let powerVm = PowerCalculationScreenViewModel()
                let powerScreen = PowerCalculationScreen()
                powerScreen.viewModel = powerVm
                return powerScreen
            case .test:
                return EquationTab()
            
            }
        } else {
            return EquationTab()
        }
    }

}

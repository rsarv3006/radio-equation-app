//
// Created by Robert J. Sarvis Jr on 5/15/23.
//

import Foundation

class HomeScreenEquationCellViewModel {
    let equationTitle: String
    let id: EquationId
    let isLocked: Bool
    
    init(equation: Equation, hasPurchasedUnlockAdvancedEquations: Bool) {
        self.equationTitle = equation.title
        self.id = equation.id
        
        self.isLocked = equation.filters.contains(.advancedFunctions) && !hasPurchasedUnlockAdvancedEquations
    }
}

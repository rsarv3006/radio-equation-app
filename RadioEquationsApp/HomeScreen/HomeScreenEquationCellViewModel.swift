import Foundation
import RadioEquationsData

class HomeScreenEquationCellViewModel {
    let equationTitle: String
    let id: EquationId
    let isLocked: Bool

    init(equation: Equation) {
        equationTitle = equation.title
        id = equation.id

        isLocked = HomeScreenEquationCellViewModel.determineIsLockStatus(equation: equation)
    }

    static func determineIsLockStatus(equation: Equation) -> Bool {
        let isAdvancedFunction = equation.filters.contains(.advancedFunctions)
        let isACFunction = equation.filters.contains(.alternatingCurrentFunctions)
        let hasPurchasedAdvancedUnlock = store.hasPurchasedUnlockAdvancedEquations
        let hasPurchasedACUnlock = store.hasPurchasedUnlockAlternatingCurrentEquations

        if isAdvancedFunction && !hasPurchasedAdvancedUnlock {
            return true
        }

        if isACFunction && !hasPurchasedACUnlock {
            return true
        }

        return false
    }
}

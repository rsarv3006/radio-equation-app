//
// Created by Robert J. Sarvis Jr on 5/15/23.
//

import Foundation

class HomeScreenEquationCellViewModel {
    let equationTitle: String
    let id: EquationId

    init(equation: Equation) {
        self.equationTitle = equation.title
        self.id = equation.id
    }
}

//
//  Double.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 11/5/23.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

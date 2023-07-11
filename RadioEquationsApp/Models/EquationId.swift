//
//  EquationIdEnum.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/20/23.
//

import Foundation

enum EquationId: String, CaseIterable, Codable {
    case ohmsLaw = "ohms-law"
    case powerEquation = "power-equation"
    case test = "test"
    
    case voltage1 = "voltage-1"
    case voltage2 = "voltage-2"
}


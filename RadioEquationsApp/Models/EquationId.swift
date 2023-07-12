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
    case voltage3 = "voltage-3"
    
    case resistance1 = "resistance-1"
    case resistance2 = "resistance-2"
    case resistance3 = "resistance-3"

    case current1 = "current-1"
    case current2 = "current-2"
    case current3 = "current-3"
    
    case power1 = "power-1"
    case power2 = "power-2"
    case power3 = "power-3"
}


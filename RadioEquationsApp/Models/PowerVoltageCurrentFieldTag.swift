//
//  PowerFieldTag.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/24/23.
//

import Foundation

enum PowerVoltageCurrentFieldTag: Int {
    case voltage = 2
    case current = 1
    case power = 0
    
    static func getFieldTagFromInt(fieldTagInt: Int) -> PowerVoltageCurrentFieldTag? {
        switch fieldTagInt {
        case PowerVoltageCurrentFieldTag.voltage.rawValue:
            return .voltage
        case PowerVoltageCurrentFieldTag.power.rawValue:
            return .power
        case PowerVoltageCurrentFieldTag.current.rawValue:
            return .current
        default:
            return nil
        }
    }
}

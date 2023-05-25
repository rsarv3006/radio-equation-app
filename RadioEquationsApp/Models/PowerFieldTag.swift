//
//  PowerFieldTag.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/24/23.
//

import Foundation

enum PowerFieldTag: Int {
    case voltage = 2
    case current = 1
    case power = 0
    
    static func getFieldTagFromInt(fieldTagInt: Int) -> PowerFieldTag? {
        switch fieldTagInt {
        case PowerFieldTag.voltage.rawValue:
            return .voltage
        case PowerFieldTag.power.rawValue:
            return .power
        case PowerFieldTag.current.rawValue:
            return .current
        default:
            return nil
        }
    }
}

//
//  SettingsViewModel.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 7/16/23.
//

import Foundation

class SettingsViewModel {
    let screenTitle = "Settings"
    
    let appVersion = buildAppVersionDisplayString()
    
    private static func buildAppVersionDisplayString() -> String {
        var returnValue = ""
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            returnValue = "App Version: \(appVersion)"
        }
        
        return returnValue
    }
    
    let goToLegalButtonTitle = "Legal"
}

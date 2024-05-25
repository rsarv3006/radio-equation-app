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

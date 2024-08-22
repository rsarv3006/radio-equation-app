import Foundation

class SettingsViewModel {
    let screenTitle = NSLocalizedString("Settings", comment: "Title for the settings screen")
    
    let appVersion = buildAppVersionDisplayString()
    
    private static func buildAppVersionDisplayString() -> String {
        var returnValue = ""
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            returnValue = String(format: NSLocalizedString("App Version: %@", comment: "App version display string"), appVersion)
        }
        
        return returnValue
    }
    
    let goToLegalButtonTitle = NSLocalizedString("Legal", comment: "Button title for navigating to legal information")
}

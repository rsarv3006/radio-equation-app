import UIKit

extension UIColor {
    struct Theme {
        static let textColor = UIColor(named: "TextColor") ?? UIColor.black
        static let backgroundColor = UIColor(named: "BackgroundColor") ?? UIColor.systemBackground
        static let altColor = UIColor(named: "Alt1Color") ?? UIColor.systemBlue
    }
}

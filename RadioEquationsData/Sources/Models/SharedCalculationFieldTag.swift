import Foundation

public enum SharedCalculationFieldTag: Int {
    case fieldOne = 0
    case fieldTwo = 1
    case fieldThree = 2

    static func getFieldTagFromInt(fieldTagInt: Int) -> SharedCalculationFieldTag? {
        switch fieldTagInt {
        case SharedCalculationFieldTag.fieldOne.rawValue:
            return .fieldOne
        case SharedCalculationFieldTag.fieldTwo.rawValue:
            return .fieldTwo
        case SharedCalculationFieldTag.fieldThree.rawValue:
            return .fieldThree
        default:
            return nil
        }
    }
}

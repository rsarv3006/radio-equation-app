import Foundation

struct AntennaGainUtils {
    static func calculateAntennaGain(powerOne: Double, powerTwo: Double) -> Double {
        let antennaGain = (10 * log10(powerTwo / powerOne)).rounded(toPlaces: 2)
        return antennaGain
    }
    
    static func calculatePowerOne(antennaGain: Double, powerTwo: Double) -> Double {

      let gainRatio = pow(10, antennaGain / 10)
      let powerOne = powerTwo / gainRatio

        return powerOne.rounded(toPlaces: 2)

    }
    
    static func calculatePowerTwo(antennaGain: Double, powerOne: Double) -> Double {

      let gainRatio = pow(10, antennaGain / 10)
      let powerTwo = powerOne * gainRatio

        return powerTwo.rounded(toPlaces: 2)

    }
}

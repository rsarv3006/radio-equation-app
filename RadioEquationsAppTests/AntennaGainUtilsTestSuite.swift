//
//  AntennaGainUtils.swift
//  RadioEquationsAppTests
//
//  Created by Robert J. Sarvis Jr on 11/5/23.
//

import XCTest

final class AntennaGainUtilsTestSuite: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalculateAntennaGain() throws {
        var antennaGain = AntennaGainUtils.calculateAntennaGain(powerOne: 10.0, powerTwo: 20.0)
        XCTAssertEqual(antennaGain, 3.01)
        
        antennaGain = AntennaGainUtils.calculateAntennaGain(powerOne: 50.0, powerTwo: 500.0)
        XCTAssertEqual(antennaGain, 10.0)
        
        antennaGain = AntennaGainUtils.calculateAntennaGain(powerOne: 80.0, powerTwo: 318.0)
        XCTAssertEqual(antennaGain, 5.99)
    }
    
    func testCalculatePowerTwo() throws {
        var powerTwo = AntennaGainUtils.calculatePowerTwo(antennaGain: 3.01, powerOne: 10.0)
        XCTAssertEqual(powerTwo, 20.0)
        
        powerTwo = AntennaGainUtils.calculatePowerTwo(antennaGain: 10.00, powerOne: 50.0)
        XCTAssertEqual(powerTwo, 500.0)
        
        powerTwo = AntennaGainUtils.calculatePowerTwo(antennaGain: 6.0, powerOne: 80.0)
        XCTAssertEqual(powerTwo, 318.49)
    }

    func testCalculatePowerOne() throws {
        var powerOne = AntennaGainUtils.calculatePowerOne(antennaGain: 3.01, powerTwo: 20.0)
        XCTAssertEqual(powerOne, 10.0)
        
        powerOne = AntennaGainUtils.calculatePowerOne(antennaGain: 10.00, powerTwo: 500.0)
        XCTAssertEqual(powerOne, 50.0)
        
        powerOne = AntennaGainUtils.calculatePowerOne(antennaGain: 6.0, powerTwo: 318.49)
        XCTAssertEqual(powerOne, 80.0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

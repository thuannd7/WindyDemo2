//
//  WindyDegTests.swift
//  WindyDemo2Tests
//
//  Created by Thuan Nguyen on 17/02/2022.
//

import XCTest
@testable import WindyDemo2

class WindyDegTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWindDegSymbol() {
        doTestWindDegSymbol(0.0, 0.0, "N")
        doTestWindDegSymbol(0.0, 45.0, "NNE")
        doTestWindDegSymbol(45.0, 45.0, "NE")
        doTestWindDegSymbol(45.0, 90.0, "ENE")
        doTestWindDegSymbol(90.0, 90.0, "E")
        doTestWindDegSymbol(90.0, 135.0, "ESE")
        doTestWindDegSymbol(135.0, 135.0, "SE")
        doTestWindDegSymbol(135.0, 180.0, "SSE")
        doTestWindDegSymbol(180.0, 180.0, "S")
        doTestWindDegSymbol(180.0, 225.0, "SSW")
        doTestWindDegSymbol(225.0, 225.0, "SW")
        doTestWindDegSymbol(225.0, 270.0, "WSW")
        doTestWindDegSymbol(270.0, 270.0, "W")
        doTestWindDegSymbol(270.0, 315.0, "WW")
        doTestWindDegSymbol(315.0, 315.0, "NW")
        doTestWindDegSymbol(315.0, 360.0, "NNW")
        doTestWindDegSymbol(360.0, 360.0, "N")
    }
    
    func doTestWindDegSymbol(_ deg_0: Double, _ deg_1: Double, _ symbol: String) {
        XCTAssertTrue(((deg_0 + deg_1)*0.5).windDegSymbol == symbol)
    }
}

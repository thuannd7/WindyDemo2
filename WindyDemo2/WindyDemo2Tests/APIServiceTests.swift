//
//  APIServiceTests.swift
//  WindyDemo2Tests
//
//  Created by Thuan Nguyen on 17/02/2022.
//

import XCTest
@testable import WindyDemo2

class APIServiceTests: XCTestCase {

    var service: WeatherService!
    
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override func setUp() {
       super.setUp()
        service = WeatherService()
    }

    override func tearDown() {
       super.tearDown()
        service = nil
    }

    func testGetWeatherOfLocation() {
        guard let service = service else {
            XCTAssertTrue(false)
            return
        }
        
        let lat = 21.0245 // of Ha Noi, Viet nam
        let long = 105.841171 // of Ha Noi, Viet Nam
        let promise = expectation(description: "Completion handler invoked")
        service.getWeatherCurrentLocation(lat: "\(lat)", long: "\(long)",
                                          complete: { (data: LocationWeatherDataModel) in
                                            DLog("data: \(data)")
                                            promise.fulfill()
                                            XCTAssertTrue(true)
                                          },
                                          failse: { (err: Error) in
                                            promise.fulfill()
                                            XCTFail("Error: \(err.localizedDescription)")
                                          })
        wait(for: [promise], timeout: 30.0)
    }
    
    func testGetForecastWeatherOfLocation () throws {
        let lat = 21.0245 // of Ha Noi, Viet nam
        let long = 105.841171 // of Ha Noi, Viet Nam
        let promise = expectation(description: "Completion handler invoked")
        service.getForecastWeatherOfLocation(lat: "\(lat)", long: "\(long)") { (data: ForecastWeatherDataModel) in
            DLog("data: \(data)")
            promise.fulfill()
            XCTAssertTrue(true)
        } failse: { (err: Error?) in
            DLog("err: \(String(describing: err?.localizedDescription))")
            promise.fulfill()
            XCTFail("Error: \(err?.localizedDescription ?? "")")
        }
        
        wait(for: [promise], timeout: 30.0)
    }
}

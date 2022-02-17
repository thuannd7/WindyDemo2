//
//  WindyHomePageViewControllerTests.swift
//  WindyDemo2Tests
//
//  Created by Thuan Nguyen on 17/02/2022.
//

import XCTest
import SnapshotTesting
@testable import WindyDemo2

class UIViewControllerTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWindyHomePageView() throws {
        let vc: UIViewController = WindyHomePageConfigure.viewController()
        assertSnapshot(matching: vc, as: .image)
    }
    
    func testSelectLocationViewController() throws {
        let vc: UIViewController = SelectLocationViewController.initWithDefaultNib()
        assertSnapshot(matching: vc, as: .image)
    }
    
    func testLocationDetailViewController() throws {
        let lat = 21.0245 // of Ha Noi, Viet nam
        let long = 105.841171 // of Ha Noi, Viet Nam
        let data: ForecastWeatherDataModel = ForecastWeatherDataModel()
        data.current.wind_speed = 20
        data.current.wind_deg = 100.0
        data.current.humidity = 10
        data.current.uvi = 1.1
        data.current.pressure = 10
        data.current.visibility = 5
        data.current.dew_point = 6
        data.current.temp = 300
        
        let vc: UIViewController = LocationDetailConfigure.viewController(lat: lat,
                                                                  long: long,
                                                                  locationName: "Ha Noi",
                                                                  isCurrentLocation: true,
                                                                  dataDetail: data)
        assertSnapshot(matching: vc, as: .image)
    }
}

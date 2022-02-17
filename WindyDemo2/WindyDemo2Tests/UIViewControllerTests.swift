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

    var homePageVC: UIViewController!
    var selectLocationVC: UIViewController!
    var detailVC: UIViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        homePageVC = WindyHomePageConfigure.viewController()
        selectLocationVC = SelectLocationViewController.initWithDefaultNib()
        
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
        
        detailVC = LocationDetailConfigure.viewController(lat: lat,
                                                          long: long,
                                                          locationName: "Ha Noi",
                                                          isCurrentLocation: true,
                                                          dataDetail: data)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        homePageVC = nil
        selectLocationVC = nil
        detailVC = nil
    }

    func testWindyHomePageView() throws {
        assertSnapshot(matching: homePageVC, as: .image)
    }
    
    func testSelectLocationViewController() throws {
        assertSnapshot(matching: selectLocationVC, as: .image)
    }
    
    func testLocationDetailViewController() throws {
        assertSnapshot(matching: detailVC, as: .image)
    }
}

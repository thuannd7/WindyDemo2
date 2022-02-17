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
        let date = Date(timeIntervalSince1970: 1645087656.215465)
        homePageVC = WindyHomePageConfigure.viewController(date)
        selectLocationVC = SelectLocationViewController.initWithDefaultNib()
        
        let lat = 21.0245 // of Ha Noi, Viet nam
        let long = 105.841171 // of Ha Noi, Viet Nam
        let data: ForecastWeatherDataModel = ForecastWeatherDataModel()
        data.current.wind_speed = 10
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
    
    func testSelectLocationViewController() throws {
        assertSnapshot(matching: selectLocationVC, as: .image)
        assertSnapshot(matching: selectLocationVC, as: .image(on: .iPhone8))
        assertSnapshot(matching: selectLocationVC, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: selectLocationVC, as: .image(on: .iPhoneX))
        assertSnapshot(matching: selectLocationVC, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: selectLocationVC, as: .image(on: .iPhoneXr))
        assertSnapshot(matching: selectLocationVC, as: .image(on: .iPhoneSe))
        assertSnapshot(matching: selectLocationVC, as: .image(on: .iPadMini))
        assertSnapshot(matching: selectLocationVC, as: .image(on: .iPadPro11))
        assertSnapshot(matching: selectLocationVC, as: .image(on: .iPadPro10_5))
        assertSnapshot(matching: selectLocationVC, as: .image(on: .iPadPro12_9))
    }
    
    func testLocationDetailViewController() throws {
        assertSnapshot(matching: detailVC, as: .image)
        assertSnapshot(matching: detailVC, as: .image(on: .iPhone8))
        assertSnapshot(matching: detailVC, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: detailVC, as: .image(on: .iPhoneX))
        assertSnapshot(matching: detailVC, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: detailVC, as: .image(on: .iPhoneXr))
        assertSnapshot(matching: detailVC, as: .image(on: .iPhoneSe))
        assertSnapshot(matching: detailVC, as: .image(on: .iPadMini))
        assertSnapshot(matching: detailVC, as: .image(on: .iPadPro11))
        assertSnapshot(matching: detailVC, as: .image(on: .iPadPro10_5))
        assertSnapshot(matching: detailVC, as: .image(on: .iPadPro12_9))
    }
    
    func testHomePageViewController() throws {
        assertSnapshot(matching: homePageVC, as: .image)
        assertSnapshot(matching: homePageVC, as: .image(on: .iPhone8))
        assertSnapshot(matching: homePageVC, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: homePageVC, as: .image(on: .iPhoneX))
        assertSnapshot(matching: homePageVC, as: .image(on: .iPhoneXsMax))
        assertSnapshot(matching: homePageVC, as: .image(on: .iPhoneXr))
        assertSnapshot(matching: homePageVC, as: .image(on: .iPhoneSe))
        assertSnapshot(matching: homePageVC, as: .image(on: .iPadMini))
        assertSnapshot(matching: homePageVC, as: .image(on: .iPadPro11))
        assertSnapshot(matching: homePageVC, as: .image(on: .iPadPro10_5))
        assertSnapshot(matching: homePageVC, as: .image(on: .iPadPro12_9))
    }
}

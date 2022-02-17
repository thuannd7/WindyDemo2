//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation
import UIKit

class LocationDetailViewModel: NSObject
{
    var lat: Double = 0.0
    var long: Double = 0.0
    var locationName: String = ""
    var isCurrentLocation: Bool = false
    var dataDetail: ForecastWeatherDataModel?
    
    init(lat _lat: Double,
         long _long: Double,
         locationName _locationName: String,
         isCurrentLocation _isCurrentLocation: Bool,
         dataDetail _dataDetail: ForecastWeatherDataModel?) {
        lat = _lat
        long = _long
        locationName = _locationName
        isCurrentLocation = _isCurrentLocation
        dataDetail = _dataDetail
    }
}

extension LocationDetailViewModel: LocationDetailViewModelInput {
    func doUpdateForecastDat(_ data: ForecastWeatherDataModel) {
        dataDetail = data
    }
}

extension LocationDetailViewModel: LocationDetailViewModelOutput {
    func getLocationName() -> String? {
        return locationName
    }
    
    func getIsCurrentLocation() -> Bool {
        return isCurrentLocation
    }
    
    func getForcastWeatherData() -> ForecastWeatherDataModel? {
        return dataDetail
    }
}

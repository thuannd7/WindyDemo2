//
//  Created by Thuan Nguyen on 16/02/2022.
//

import Foundation
import UIKit

class WindyHomePageViewModel: NSObject
{
    var lastTimeUpdate: Date = Date()
    var listFavorite: [LocationModel] = []
    private var mapForecastWeatherData: [String: ForecastWeatherDataModel] = [:]
    private var currentLocationWeatherData: LocationWeatherDataModel?
}

extension WindyHomePageViewModel: WindyHomePageViewModelInput {
    func doUpdateLastTime() {
        lastTimeUpdate = Date()
    }
    
    func doUpdateForecaseWeatherData(key: String, data: ForecastWeatherDataModel?) {
        guard let data = data else {
            mapForecastWeatherData[key] = nil
            return
        }
        
        mapForecastWeatherData[key] = data
    }
    
    func didUpdateCurrentLocationWeatherData(data: LocationWeatherDataModel) {
        currentLocationWeatherData = data
    }
}

extension WindyHomePageViewModel: WindyHomePageViewModelOutput {
    func getTitle() -> String? {
        return "Windy Demo".localized
    }
    
    func getLastTimeStr() -> String? {
        return lastTimeUpdate.toStringWithFormat("HH:mm - dd MMM, YYYY")
    }
    
    func getListLocationCount() -> Int {
        return listFavorite.count
    }
    
    func getCurrentLocationWeatherData() -> LocationWeatherDataModel? {
        return currentLocationWeatherData
    }
    
    func getCurrentLocationForecastWeatherData() -> ForecastWeatherDataModel? {
        return mapForecastWeatherData["current"]
    }
    
    func getWeatherData(location: LocationModel) -> LocationWeatherDataModel? {
        return nil
    }
}

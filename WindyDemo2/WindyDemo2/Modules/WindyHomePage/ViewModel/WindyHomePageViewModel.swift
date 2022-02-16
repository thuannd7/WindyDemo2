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
    
    override init() {
        listFavorite = DataManager.shared.getListLocationFavorite()
    }
}

extension WindyHomePageViewModel: WindyHomePageViewModelInput {
    func doUpdateForecaseWeatherData(key: String, data: ForecastWeatherDataModel?) {
        guard let data = data else {
            mapForecastWeatherData[key] = nil
            return
        }
        
        mapForecastWeatherData[key] = data
        lastTimeUpdate = Date()
    }
    
    func doAddFavorite(_ location: LocationModel) {
        let result = listFavorite.filter { (item: LocationModel) in
            return item.id == location.id
        }
        
        if result.isEmpty {
            listFavorite.append(location)
            DataManager.shared.saveListFavoriteLocation(listFavorite)
        }
    }
    
    func doRemoveFavorite(_ location: LocationModel) {
        listFavorite.removeAll { (item: LocationModel) in
            return item.id == location.id
        }
        DataManager.shared.saveListFavoriteLocation(listFavorite)
    }
    
    func doUpdateCurrentLocationWeatherData(data: LocationWeatherDataModel) {
        currentLocationWeatherData = data
        lastTimeUpdate = Date()
    }
    
    func getLocation(index: Int) -> LocationModel? {
        return listFavorite.count > index ? listFavorite[index] : nil
    }
    
    func getLocationForecastData(index: Int) -> ForecastWeatherDataModel? {
        guard let location = getLocation(index: index) else {
            return nil
        }
        return mapForecastWeatherData[location.id]
    }
}

extension WindyHomePageViewModel: WindyHomePageViewModelOutput {
    func getTitle() -> String? {
        return "Windy Demo".localized
    }
    
    func getLastTimeStr() -> String? {
        if lastTimeUpdate.isInToday {
            return "Updated".localized + ": " + "Today at".localized + " " + lastTimeUpdate.toStringWithFormat("HH:mm:ss")
        }
        return "Updated".localized + ": " + lastTimeUpdate.toStringWithFormat("HH:mm:ss - dd MMM, YYYY")
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
    
    func getFavoriteList() -> [LocationModel] {
        return listFavorite
    }
}

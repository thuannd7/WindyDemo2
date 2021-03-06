//
//  Created by Thuan Nguyen on 16/02/2022.
//

import Foundation
import UIKit
import CoreLocation

class WindyHomePagePresenter: NSObject {
    weak var view: WindyHomePageViewInput?
    var interactor: WindyHomePageInteractorInput?
    var wireFrame: WindyHomePageWireFrameInput?
    var viewModel: WindyHomePageViewModel?
    internal let locationHelper = LocationHelper()
    
    deinit {
        view = nil
        interactor = nil
        wireFrame = nil
        viewModel = nil
    }
}

// MARK:
// MARK: VIEW
extension WindyHomePagePresenter: WindyHomePageViewOutput {
    func viewDidLoad() {
        
    }
    
    func viewDidAppear() {
        doPullToRefresh()
    }
    
    func doPullToRefresh() {
        doGetCurrentLocationData()
        if let list = viewModel?.getFavoriteList() {
            for item in list {
                interactor?.doGetForecastWeatherData(key: item.id, item.lat, item.long)
            }
        }
    }
    
    func doSelectLocation() {
        guard let list = viewModel?.getFavoriteList() else {
            return
        }
        wireFrame?.doOpenSelectLocationScreen(listLocationSelected: list)
    }
    
    func doRemoveLocationFromFavoriteList(_ location: LocationModel) {
        viewModel?.doRemoveFavorite(location)
        view?.doReloadView()
    }
    
    func doSelectLocation(_ indexPath: IndexPath) {
        guard let viewModel = viewModel, let location = viewModel.getLocation(index: indexPath.row) else {
            return
        }

        let forecastData = viewModel.getLocationForecastData(index: indexPath.row)
        wireFrame?.doGoDetail(lat: location.lat,
                              long: location.long,
                              locationName: location.name,
                              isCurrentLocation: false,
                              dataDetail: forecastData)
    }
    
    func doViewCurrentLocationDetail() {
        guard let viewModel = viewModel, let weatherData = viewModel.getCurrentLocationWeatherData() else {
            return
        }
        
        let forecastData = viewModel.getCurrentLocationForecastWeatherData()
        
        wireFrame?.doGoDetail(lat: weatherData.lat,
                              long: weatherData.long,
                              locationName: weatherData.name,
                              isCurrentLocation: true,
                              dataDetail: forecastData)
    }
}

extension WindyHomePagePresenter {
    internal func doGetCurrentLocationData() {
        locationHelper.getCurrentLocation { [weak self] (location: CLLocation) in
            let coordinate = location.coordinate
            self?.interactor?.doGetForecastWeatherData(key: "current", coordinate.latitude, coordinate.longitude)
            self?.interactor?.doGetCurrentLocationData(coordinate.latitude, coordinate.longitude)
        } _: { [weak self] (status: CLAuthorizationStatus) in
            DLog("false: \(status)")
            self?.view?.doReloadView()
        }
    }
}

// MARK:
// MARK: INTERACTOR
extension WindyHomePagePresenter: WindyHomePageInteractorOutput {
    func didGetForecastWeatherData(key: String, data: ForecastWeatherDataModel) {
        viewModel?.doUpdateForecaseWeatherData(key: key, data: data)
        view?.doReloadView()
        DLog("didGetForecastWeatherData \(key) - \(data.current.temp.tempK2C)")
    }
    
    func didCurrentLocationWeatherData(data: LocationWeatherDataModel) {
        viewModel?.doUpdateCurrentLocationWeatherData(data: data)
        view?.doReloadView()
        DLog("didCurrentLocationWeatherData \(data.name)")
    }
    
    func didRequestFailed(err: Error) {
        
    }
}

// MARK:
// MARK: WIRE FRAME
extension WindyHomePagePresenter: WindyHomePageWireFrameOutput {
    func didSelectLocation(_ location: LocationModel) {
        viewModel?.doAddFavorite(location)
        view?.doReloadView()
        interactor?.doGetForecastWeatherData(key: location.id, location.lat, location.long)
    }
}

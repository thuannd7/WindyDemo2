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
}

// MARK:
// MARK: VIEW
extension WindyHomePagePresenter: WindyHomePageViewOutput {
    func viewDidLoad() {
        
    }
    
    func viewDidAppear() {
        doGetCurrentLocationData()
    }
    
    func doPullToRefresh() {
        doGetCurrentLocationData()
    }
    
    func doSelectLocation() {
        wireFrame?.doOpenSelectLocationScreen()
    }
    
    func doRemoveLocationFromFavoriteList(_ location: LocationModel) {
        viewModel?.doRemoveFavorite(location)
        view?.doReloadView()
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
        DLog("didGetForecastWeatherData \(key)")
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

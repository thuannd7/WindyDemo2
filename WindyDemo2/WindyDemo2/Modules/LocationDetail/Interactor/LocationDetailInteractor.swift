//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation
import UIKit

class LocationDetailInteractor: NSObject
{
    weak var presenter: LocationDetailInteractorOutput?
    let service = WeatherService()
}

extension LocationDetailInteractor: LocationDetailInteractorInput {
    func doGetForecastWeatherData(_ lat: Double, _ long: Double) {
        service.getForecastWeatherOfLocation(lat: "\(lat)", long: "\(long)") { [weak self] (data: ForecastWeatherDataModel) in
            self?.presenter?.didGetData(data)
        } failse: { [weak self] (err: Error) in
            self?.presenter?.didGetFailed(err)
        }
    }
}

//
//  Created by Thuan Nguyen on 16/02/2022.
//

import Foundation
import UIKit

class WindyHomePageInteractor: NSObject
{
    weak var presenter: WindyHomePageInteractorOutput?
    let service = WeatherService()
}

extension WindyHomePageInteractor: WindyHomePageInteractorInput {
    func doGetForecastWeatherData(key: String, _ lat: Double, _ long: Double) {
        service.getForecastWeatherOfLocation(lat: "\(lat)", long: "\(long)") { [weak self] (data: ForecastWeatherDataModel) in
            self?.presenter?.didGetForecastWeatherData(key: key, data: data)
        } failse: { [weak self] (err: Error) in
            self?.presenter?.didRequestFailed(err: err)
        }
    }
    
    func doGetCurrentLocationData(_ lat: Double, _ long: Double) {
        service.getWeatherCurrentLocation(lat: "\(lat)",
                                          long: "\(long)",
                                          complete: { [weak self] (data: LocationWeatherDataModel) in
                                            self?.presenter?.didCurrentLocationWeatherData(data: data)
                                          }, failse: { [weak self] (err: Error) in
                                            self?.presenter?.didRequestFailed(err: err)
                                          })
    }
}

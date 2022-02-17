//
//  ForecastWeatherDataModel.swift
//  WindyDemo2
//
//  Created by Thuan Nguyen on 16/02/2022.
//

import UIKit
import SwiftyJSON

class ForecastWeatherDataModel: NSObject {
    var current: ForecaseInfor = ForecaseInfor()
    var hourly: [ForecaseInfor] = []
    
    override init() {
        current = ForecaseInfor()
        super.init()
    }
    
    init(_ json: JSON) {
        current = ForecaseInfor(json["current"])
        
        for sub in json["hourly"].arrayValue {
            hourly.append(ForecaseInfor(sub))
        }
    }
}

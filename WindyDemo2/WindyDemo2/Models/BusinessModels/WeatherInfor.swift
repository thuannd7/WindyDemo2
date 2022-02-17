//
//  WeatherInfor.swift
//  WindyDemo2
//
//  Created by Thuan Nguyen on 16/02/2022.
//

import UIKit
import SwiftyJSON

class WeatherInfor: NSObject {
    var desc: String = ""
    var id: Int = 0
    var main: String = ""
    var icon: String = ""
    
    init(_ json: JSON) {
        desc = json["description"].stringValue
        id = json["id"].intValue
        main = json["main"].stringValue
        icon = json["icon"].stringValue
    }
}

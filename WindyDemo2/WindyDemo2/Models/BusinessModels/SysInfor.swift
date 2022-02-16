//
//  SysInfor.swift
//  WindyDemo2
//
//  Created by Thuan Nguyen on 16/02/2022.
//

import UIKit
import SwiftyJSON

class SysInfor: NSObject {
    var country: String = ""
    var sunset: Double = 0.0
    var sunrise: Double = 0.0
    
    init(_ json: JSON) {
        country = json["country"].stringValue
        sunset = json["sunset"].doubleValue
        sunrise = json["sunrise"].doubleValue
    }
}

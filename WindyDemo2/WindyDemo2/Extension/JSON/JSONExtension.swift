//
//  JSONExtension.swift
//  WindyDemo2
//
//  Created by Thuan Nguyen on 16/02/2022.
//

import UIKit
import SwiftyJSON

extension JSON {
    static func getJSONWithPath(_ path: String) -> JSON? {
        if let path = Bundle.main.path(forResource: path, ofType: "json") {
            do {
                guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
                    let jsonObj = try? JSON(data: data) else {
                        return nil
                }
                
                return jsonObj
            }
        }
        return nil
    }
}

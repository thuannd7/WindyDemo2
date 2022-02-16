//
//  LocationDataManager.swift
//  WindyDemo2
//
//  Created by Thuan Nguyen on 16/02/2022.
//

import UIKit
import SwiftyJSON

class LocationDataManager: NSObject {
    static let shared: LocationDataManager = LocationDataManager()
    
    private var listAllLocation: [LocationModel] = []
    private var mapAllLocation: [String: LocationModel] = [:]
    private var listFavoriteLocationID: [String] = []
    var completeGetDataHander: (() -> Void)?
    
    override init() {
        super.init()
        doFetchDataLocal()
    }
    
    func doFetchDataLocal() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            do {
                guard let strongSelf = self else {
                    return
                }
                if let bundlePath = Bundle.main.path(forResource: "city.list", ofType: "json"),
                    let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    let json = try JSON(data: jsonData)

                    var _list: [LocationModel] = []
                    var _map: [String: LocationModel] = [:]

                    for sub in json.arrayValue {
                        let item = LocationModel(json: sub)
                        _list.append(item)
                        _map[item.id] = item
                    }

                    DispatchQueue.main.async {
                        strongSelf.listAllLocation = _list
                        strongSelf.mapAllLocation = _map
                        
                        let userDefault = UserDefaults.standard

                        if let data = userDefault.value(forKey: "listFavoriteLocationID") as? [String] {
                            strongSelf.listFavoriteLocationID = data
                        }
                        
                        strongSelf.completeGetDataHander?()
                        strongSelf.completeGetDataHander = nil
                    }
                }
            } catch {
                
            }
        }
    }
    
    func doSearchLocation(name: String, complete: ((_ result: [LocationModel]) -> Void)?) {
        if listAllLocation.isEmpty {
            DispatchQueue.global(qos: .background).async { [weak self] in
                do {
                    guard let strongSelf = self else {
                        return
                    }
                    
                    if let bundlePath = Bundle.main.path(forResource: "city.list", ofType: "json"),
                        let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                        let json = try JSON(data: jsonData)
                        
                        var _list: [LocationModel] = []
                        var _map: [String: LocationModel] = [:]
                        
                        for sub in json.arrayValue {
                            let item = LocationModel(json: sub)
                            _list.append(item)
                            _map[item.id] = item
                        }
                        
                        strongSelf.listAllLocation = _list
                        strongSelf.mapAllLocation = _map
                        
                        let searchStr = name.searchString
                        
                        let result = _list.filter { (item: LocationModel) in
                            let isExit = item.searchStr.contains(searchStr)
                            return isExit
                        }
                        
                        DispatchQueue.main.async {
                            complete?(result)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        complete?([])
                    }
                }
            }
            
        } else {
            DispatchQueue.global(qos: .background).async { [weak self] in
                if let strong = self {
                    let searchStr = name.searchString
                    
                    let result = strong.listAllLocation.filter { (item: LocationModel) in
                        let isExit = item.searchStr.contains(searchStr)
                        return isExit
                    }
                    
                    DispatchQueue.main.async {
                        complete?(result)
                    }
                }
            }
        }
    }
}

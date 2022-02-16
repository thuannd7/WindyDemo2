//
//  DataManager.swift
//  WindyDemo2
//
//  Created by Thuan Nguyen on 16/02/2022.
//

import UIKit
import SwiftyJSON

class DataManager: NSObject {
    static let shared: DataManager = DataManager()
    
    private var listAllLocation: [LocationModel] = []
    private var mapAllLocation: [String: LocationModel] = [:]
    private var listFavoriteLocationID: [String] = []
    
    override init() {
        super.init()
    }
    
    func isInFavorite(_ item: LocationModel) -> Bool {
        let result = listFavoriteLocationID.filter { (id: String) in
            return item.id == id
        }
        
        return !result.isEmpty
    }
    
    func doAddLocationToFavorite(_ item: LocationModel) {
        let result = listFavoriteLocationID.filter { (id: String) in
            return item.id == id
        }
        
        if result.count == 0 {
            listFavoriteLocationID.append(item.id)
            saveData()
        }
    }
    
    func doRemoveLocationFromFavorite(_ item: LocationModel) {
        listFavoriteLocationID.removeAll { (id: String) in
            return item.id == id
        }
        
        saveData()
    }
    
    func getListLocationFavorite() -> [LocationModel] {
        var list: [LocationModel] = []
        for id in listFavoriteLocationID {
            if let item = mapAllLocation[id] {
                list.append(item)
            }
        }
        
        return list
    }
    
    func getLocationWithId(_ id: String) -> LocationModel? {
        return mapAllLocation[id]
    }
    
    private func saveData() {
        let userDefault = UserDefaults.standard
        userDefault.setValue(listFavoriteLocationID, forKey: "listFavoriteLocationID")
        userDefault.synchronize() 
    }
}

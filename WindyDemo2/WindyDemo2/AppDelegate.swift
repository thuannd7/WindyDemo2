//
//  AppDelegate.swift
//  WindyDemo2
//
//  Created by Thuan Nguyen on 16/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DataManager.shared.fetchData()
        LocalizationStringHelper.setUpDefaultLanguage()
        let _window = UIWindow(frame: UIScreen.main.bounds)
        let vc = WindyHomePageConfigure.viewController(Date())
        _window.rootViewController = vc
        _window.backgroundColor = .white
        _window.makeKeyAndVisible()
        window = _window
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
}


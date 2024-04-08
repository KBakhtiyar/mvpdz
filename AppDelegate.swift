//
//  AppDelegate.swift
//  ДЗ АРХИТЕКТУРА
//
//  Created by BK on 05.04.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        window?.rootViewController = UINavigationController(rootViewController:RealmViewController())
        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }
}
